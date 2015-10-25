
(define (domain pipesworld-tankage-ae)
  (:requirements :strips :typing)

  (:types pipe area product count)

  (:constants
   ;; the products (petroleum derivatives)
   lco gasoleo rat-a oca1 oc1b - product

   ;; need to declare a few numbers
   c0 c1 - count
   )

  (:predicates
   ;; network topology
   (connect ?from ?to - area ?pipe - pipe)

   ;; instead of unitary/non-unitary, we have pipe length
   (length ?pipe - pipe ?len - count)

   ;; current contents of a pipeline segment;
   ;; following the convention of the IPC4 domain version,
   ;; the lowest-numbered ("first") batch is the one closest
   ;; to the "from" area, and the highest-numbered ("last")
   ;; batch is the one closest to the "to" area
   (contents ?pipe - pipe ?pos - count ?prod - product)

   ;; number of batches of given product type that are in
   ;; a storage area
   (number-on ?prod - product ?area - area ?n - count)

   ;; free tank space for product in area
   (free-space ?prod - product ?area - area ?n - count)

   ;; may-interface
   (may-interface ?prod-a ?prod-b - product)

   ;; to control splitting process (push/pop vs. update)
   (normal ?pipe - pipe)
   (push-updating ?pipe - pipe ?pos - count ?batch - product)
   (pop-updating ?pipe - pipe ?pos - count ?batch - product)

   ;; ?d = ?c + 1
   (inc ?c - count ?d - count)
   ;; ?c < ?d
   ;; (less ?c - count ?d - count)
   )


  ;; PUSH-START action
  (:action PUSH-START
    :parameters
    (?pipe - pipe  ;; the pipe
     ?from-area - area  ;; pipe end points
     ?to-area - area
     ?batch-in - product  ;; type of product pushed
     ?n-on-from - count  ;; number of that type in from area
     ?n-minus-one - count  ;; ?n-on-from - 1
     ?n-free-from - count  ;; free space for that type in from area
     ?n-free-plus-one - count  ;; ?n-free-from + 1
     ?first-batch - product  ;; product in pipe near from area
     )
    :precondition
    (and
     ;; normal mode (no update in progress)
     (normal ?pipe)
     ;; variable bindings
     (connect ?from-area ?to-area ?pipe)
     (inc ?n-minus-one ?n-on-from)
     (inc ?n-free-from ?n-free-plus-one)
     ;; inserted batch must be in "from-area"
     (number-on ?batch-in ?from-area ?n-on-from)
     (free-space ?batch-in ?from-area ?n-free-from)
     ;; bind product type first in pipe
     (contents ?pipe c1 ?first-batch)
     ;; interface restriction
     (may-interface ?batch-in ?first-batch)
     )
    :effect
    (and 
     ;; now in update mode; the push-updating predicate keeps track
     ;; where in the pipe we are, and the type of the "floating" batch
     (push-updating ?pipe c1 ?first-batch)
     (not (normal ?pipe))
     ;; the inserted batch is now at pos 1 in the pipeline segment
     (contents ?pipe c1 ?batch-in)
     ;; don't delete if they're the same type
     (when (not (= ?batch-in ?first-batch))
       (not (contents ?pipe c1 ?first-batch)))
     ;; inserted batch-atom is removed from area
     (not (number-on ?batch-in ?from-area ?n-on-from))
     (number-on ?batch-in ?from-area ?n-minus-one)
     (not (free-space ?batch-in ?from-area ?n-free-from))
     (free-space ?batch-in ?from-area ?n-free-plus-one)
     )
    )

  ;; PUSH-CONTINUE action
  (:action PUSH-CONTINUE
    :parameters
    (?pipe - pipe  ;; the pipe
     ?len - count  ;; its length
     ?pos - count  ;; current update position
     ?next-pos - count  ;; next update position
     ?batch-in - product  ;; type of product in floating batch
     ?batch-out - product  ;; type of product at current position
     )
    :precondition
    (and
     ;; check mode and position, and bind the "floating" batch
     (push-updating ?pipe ?pos ?batch-in)
     ;; bind parameters
     (length ?pipe ?len)
     (inc ?pos ?next-pos)
     (not (= ?pos ?len))
     (contents ?pipe ?next-pos ?batch-out)
     )
    :effect
    (and 
     ;; advance update
     (not (push-updating ?pipe ?pos ?batch-in))
     (push-updating ?pipe ?next-pos ?batch-out)
     ;; update pipe contents
     (contents ?pipe ?next-pos ?batch-in)
     (when (not (= ?batch-in ?batch-out))
       (not (contents ?pipe ?next-pos ?batch-out)))
     )
    )

  ;; PUSH-END action
  (:action PUSH-END
    :parameters
    (?pipe - pipe  ;; the pipe
     ?len - count  ;; its length
     ?from-area - area  ;; pipe end points
     ?to-area - area
     ?batch-out - product  ;; type of product pushed out
     ?n-on-to - count  ;; number of that type in to area
     ?n-plus-one - count  ;; ?n-on-to + 1
     ?n-free-to - count  ;; free space for type in to area
     ?n-free-minus-one - count  ;; ?n-free-to - 1
     )
    :precondition
    (and
     (connect ?from-area ?to-area ?pipe)
     (length ?pipe ?len)
     ;; check mode and position, and bind the "floating" batch
     (push-updating ?pipe ?len ?batch-out)
     ;; bind parameters
     (inc ?n-on-to ?n-plus-one)
     (inc ?n-free-minus-one ?n-free-to)
     (number-on ?batch-out ?to-area ?n-on-to)
     (free-space ?batch-out ?to-area ?n-free-to)
     )
    :effect
    (and 
     ;; back to normal mode
     (not (push-updating ?pipe ?len ?batch-out))
     (normal ?pipe)
     ;; increment number of batch-out type in to-area
     (not (number-on ?batch-out ?to-area ?n-on-to))
     (number-on ?batch-out ?to-area ?n-plus-one)
     (not (free-space ?batch-out ?to-area ?n-free-to))
     (free-space ?batch-out ?to-area ?n-free-minus-one)
     )
    )


  ;; POP-START action
  (:action POP-START
    :parameters
    (?pipe - pipe  ;; the pipe
     ?len - count  ;; its length
     ?from-area - area  ;; pipe end points
     ?to-area - area
     ?batch-in - product  ;; type of product pushed
     ?n-on-to - count  ;; number of that type in to area
     ?n-minus-one - count  ;; ?n-on-to - 1
     ?n-free-to - count  ;; free space for type in to area
     ?n-free-plus-one - count  ;; ?n-free-to + 1
     ?last-batch - product  ;; product in pipe near to area
     )
    :precondition
    (and
     ;; normal mode
     (normal ?pipe)
     ;; variable bindings
     (connect ?from-area ?to-area ?pipe)
     (length ?pipe ?len)
     (inc ?n-minus-one ?n-on-to)
     (inc ?n-free-to ?n-free-plus-one)
     ;; inserted batch must be in "to-area"
     (number-on ?batch-in ?to-area ?n-on-to)
     (free-space ?batch-in ?to-area ?n-free-to)
     ;; bind product type last in pipe
     (contents ?pipe ?len ?last-batch)
     ;; interface restriction
     (may-interface ?batch-in ?last-batch)
     )
    :effect
    (and 
     ;; now in update mode; pop-updating is analogous to push-updating
     ;; (though note here we start at position ?len, i.e., at the tail
     ;; end of the pipe)
     (pop-updating ?pipe ?len ?last-batch)
     (not (normal ?pipe))
     ;; the inserted batch is now at pos ?len in the pipeline segment
     (contents ?pipe ?len ?batch-in)
     ;; don't delete if they're the same type
     (when (not (= ?batch-in ?last-batch))
       (not (contents ?pipe ?len ?last-batch)))
     ;; inserted batch-atom is removed from to-area
     (not (number-on ?batch-in ?to-area ?n-on-to))
     (number-on ?batch-in ?to-area ?n-minus-one)
     (not (free-space ?batch-in ?to-area ?n-free-to))
     (free-space ?batch-in ?to-area ?n-free-plus-one)
     )
    )

  ;; POP-CONTINUE action
  (:action POP-CONTINUE
    :parameters
    (?pipe - pipe  ;; the pipe
     ?pos - count  ;; current update position
     ?next-pos - count  ;; next update position
     ?batch-in - product  ;; type of product in floating batch
     ?batch-out - product  ;; type of product at current position
     )
    :precondition
    (and
     ;; check mode and position, and bind the "floating" batch
     (pop-updating ?pipe ?pos ?batch-in)
     ;; bind parameters (here, ?next-pos = ?pos - 1)
     (inc ?next-pos ?pos)
     (not (= ?pos c1))
     (contents ?pipe ?next-pos ?batch-out)
     )
    :effect
    (and 
     ;; advance update
     (not (pop-updating ?pipe ?pos ?batch-in))
     (pop-updating ?pipe ?next-pos ?batch-out)
     ;; update pipe contents
     (contents ?pipe ?next-pos ?batch-in)
     (when (not (= ?batch-in ?batch-out))
       (not (contents ?pipe ?next-pos ?batch-out)))
     )
    )

  ;; POP-END action
  (:action POP-END
    :parameters
    (?pipe - pipe  ;; the pipe
     ?from-area - area  ;; pipe end points
     ?to-area - area
     ?batch-out - product  ;; type of product popped out
     ?n-on-from - count  ;; number of that type in from-area
     ?n-plus-one - count  ;; ?n-on-from + 1
     ?n-free-from - count  ;; free space for type in from-area
     ?n-free-minus-one - count  ;; ?n-free-from - 1
     )
    :precondition
    (and
     (connect ?from-area ?to-area ?pipe)
     ;; check mode and position, and bind the "floating" batch
     (pop-updating ?pipe c1 ?batch-out)
     ;; bind parameters
     (inc ?n-on-from ?n-plus-one)
     (inc ?n-free-minus-one ?n-free-from)
     (number-on ?batch-out ?from-area ?n-on-from)
     (free-space ?batch-out ?from-area ?n-free-from)
     )
    :effect
    (and 
     ;; back to normal mode
     (not (pop-updating ?pipe c1 ?batch-out))
     (normal ?pipe)
     ;; increment number of batch-out type in from-area
     (not (number-on ?batch-out ?from-area ?n-on-from))
     (number-on ?batch-out ?from-area ?n-plus-one)
     (not (free-space ?batch-out ?from-area ?n-free-from))
     (free-space ?batch-out ?from-area ?n-free-minus-one)
     )
    )

  ;; end of domain definition
  )
