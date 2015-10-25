(define (problem deadlock3)
  (:domain philosophers)
  (:objects
  p1 - philosopher
  f1 - fork
  p2 - philosopher
  f2 - fork
  p3 - philosopher
  f3 - fork
  p4 - philosopher
  f4 - fork
  p5 - philosopher
  f5 - fork
  p6 - philosopher
  f6 - fork
  p7 - philosopher
  f7 - fork
  p8 - philosopher
  f8 - fork
  p9 - philosopher
  f9 - fork
  p10 - philosopher
  f10 - fork
  p11 - philosopher
  f11 - fork
  p12 - philosopher
  f12 - fork
  p13 - philosopher
  f13 - fork
  p14 - philosopher
  f14 - fork
  p15 - philosopher
  f15 - fork
  p16 - philosopher
  f16 - fork
  p17 - philosopher
  f17 - fork
  p18 - philosopher
  f18 - fork
  p19 - philosopher
  f19 - fork
  p20 - philosopher
  f20 - fork
  p21 - philosopher
  f21 - fork
  p22 - philosopher
  f22 - fork
  p23 - philosopher
  f23 - fork
  p24 - philosopher
  f24 - fork
  p25 - philosopher
  f25 - fork
  p26 - philosopher
  f26 - fork
  p27 - philosopher
  f27 - fork
  p28 - philosopher
  f28 - fork
  p29 - philosopher
  f29 - fork
  p30 - philosopher
  f30 - fork
  p31 - philosopher
  f31 - fork
  p32 - philosopher
  f32 - fork
  p33 - philosopher
  f33 - fork
  p34 - philosopher
  f34 - fork
  p35 - philosopher
  f35 - fork
  p36 - philosopher
  f36 - fork
  p37 - philosopher
  f37 - fork
  p38 - philosopher
  f38 - fork
  p39 - philosopher
  f39 - fork
  )
  (:init
   (left-of p1 f1)
   (right-of p1 f39)
   (left-of p2 f2)
   (right-of p2 f1)
   (left-of p3 f3)
   (right-of p3 f2)
   (left-of p4 f4)
   (right-of p4 f3)
   (left-of p5 f5)
   (right-of p5 f4)
   (left-of p6 f6)
   (right-of p6 f5)
   (left-of p7 f7)
   (right-of p7 f6)
   (left-of p8 f8)
   (right-of p8 f7)
   (left-of p9 f9)
   (right-of p9 f8)
   (left-of p10 f10)
   (right-of p10 f9)
   (left-of p11 f11)
   (right-of p11 f10)
   (left-of p12 f12)
   (right-of p12 f11)
   (left-of p13 f13)
   (right-of p13 f12)
   (left-of p14 f14)
   (right-of p14 f13)
   (left-of p15 f15)
   (right-of p15 f14)
   (left-of p16 f16)
   (right-of p16 f15)
   (left-of p17 f17)
   (right-of p17 f16)
   (left-of p18 f18)
   (right-of p18 f17)
   (left-of p19 f19)
   (right-of p19 f18)
   (left-of p20 f20)
   (right-of p20 f19)
   (left-of p21 f21)
   (right-of p21 f20)
   (left-of p22 f22)
   (right-of p22 f21)
   (left-of p23 f23)
   (right-of p23 f22)
   (left-of p24 f24)
   (right-of p24 f23)
   (left-of p25 f25)
   (right-of p25 f24)
   (left-of p26 f26)
   (right-of p26 f25)
   (left-of p27 f27)
   (right-of p27 f26)
   (left-of p28 f28)
   (right-of p28 f27)
   (left-of p29 f29)
   (right-of p29 f28)
   (left-of p30 f30)
   (right-of p30 f29)
   (left-of p31 f31)
   (right-of p31 f30)
   (left-of p32 f32)
   (right-of p32 f31)
   (left-of p33 f33)
   (right-of p33 f32)
   (left-of p34 f34)
   (right-of p34 f33)
   (left-of p35 f35)
   (right-of p35 f34)
   (left-of p36 f36)
   (right-of p36 f35)
   (left-of p37 f37)
   (right-of p37 f36)
   (left-of p38 f38)
   (right-of p38 f37)
   (left-of p39 f39)
   (right-of p39 f38)
   (ph-state-6 p1)
   (free f1)
   (may-take f1)
   (may-return f1)
   (ph-state-6 p2)
   (free f2)
   (may-take f2)
   (may-return f2)
   (ph-state-6 p3)
   (free f3)
   (may-take f3)
   (may-return f3)
   (ph-state-6 p4)
   (free f4)
   (may-take f4)
   (may-return f4)
   (ph-state-6 p5)
   (free f5)
   (may-take f5)
   (may-return f5)
   (ph-state-6 p6)
   (free f6)
   (may-take f6)
   (may-return f6)
   (ph-state-6 p7)
   (free f7)
   (may-take f7)
   (may-return f7)
   (ph-state-6 p8)
   (free f8)
   (may-take f8)
   (may-return f8)
   (ph-state-6 p9)
   (free f9)
   (may-take f9)
   (may-return f9)
   (ph-state-6 p10)
   (free f10)
   (may-take f10)
   (may-return f10)
   (ph-state-6 p11)
   (free f11)
   (may-take f11)
   (may-return f11)
   (ph-state-6 p12)
   (free f12)
   (may-take f12)
   (may-return f12)
   (ph-state-6 p13)
   (free f13)
   (may-take f13)
   (may-return f13)
   (ph-state-6 p14)
   (free f14)
   (may-take f14)
   (may-return f14)
   (ph-state-6 p15)
   (free f15)
   (may-take f15)
   (may-return f15)
   (ph-state-6 p16)
   (free f16)
   (may-take f16)
   (may-return f16)
   (ph-state-6 p17)
   (free f17)
   (may-take f17)
   (may-return f17)
   (ph-state-6 p18)
   (free f18)
   (may-take f18)
   (may-return f18)
   (ph-state-6 p19)
   (free f19)
   (may-take f19)
   (may-return f19)
   (ph-state-6 p20)
   (free f20)
   (may-take f20)
   (may-return f20)
   (ph-state-6 p21)
   (free f21)
   (may-take f21)
   (may-return f21)
   (ph-state-6 p22)
   (free f22)
   (may-take f22)
   (may-return f22)
   (ph-state-6 p23)
   (free f23)
   (may-take f23)
   (may-return f23)
   (ph-state-6 p24)
   (free f24)
   (may-take f24)
   (may-return f24)
   (ph-state-6 p25)
   (free f25)
   (may-take f25)
   (may-return f25)
   (ph-state-6 p26)
   (free f26)
   (may-take f26)
   (may-return f26)
   (ph-state-6 p27)
   (free f27)
   (may-take f27)
   (may-return f27)
   (ph-state-6 p28)
   (free f28)
   (may-take f28)
   (may-return f28)
   (ph-state-6 p29)
   (free f29)
   (may-take f29)
   (may-return f29)
   (ph-state-6 p30)
   (free f30)
   (may-take f30)
   (may-return f30)
   (ph-state-6 p31)
   (free f31)
   (may-take f31)
   (may-return f31)
   (ph-state-6 p32)
   (free f32)
   (may-take f32)
   (may-return f32)
   (ph-state-6 p33)
   (free f33)
   (may-take f33)
   (may-return f33)
   (ph-state-6 p34)
   (free f34)
   (may-take f34)
   (may-return f34)
   (ph-state-6 p35)
   (free f35)
   (may-take f35)
   (may-return f35)
   (ph-state-6 p36)
   (free f36)
   (may-take f36)
   (may-return f36)
   (ph-state-6 p37)
   (free f37)
   (may-take f37)
   (may-return f37)
   (ph-state-6 p38)
   (free f38)
   (may-take f38)
   (may-return f38)
   (ph-state-6 p39)
   (free f39)
   (may-take f39)
   (may-return f39)
   )
  (:goal (and (blocked p1) (blocked p2) (blocked p3) (blocked p4) (blocked p5) (blocked p6) (blocked p7) (blocked p8) (blocked p9) (blocked p10) (blocked p11) (blocked p12) (blocked p13) (blocked p14) (blocked p15) (blocked p16) (blocked p17) (blocked p18) (blocked p19) (blocked p20) (blocked p21) (blocked p22) (blocked p23) (blocked p24) (blocked p25) (blocked p26) (blocked p27) (blocked p28) (blocked p29) (blocked p30) (blocked p31) (blocked p32) (blocked p33) (blocked p34) (blocked p35) (blocked p36) (blocked p37) (blocked p38) (blocked p39)))
 )
