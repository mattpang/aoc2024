# ./uiua day21.ua
# go run it on https://www.uiua.org/pad
Transition ← ▽:"<^v>"↥0⊂⇌⊸¯
$ 789
$ 456
$ 123
$  0A
⊜∘⊸≠@\n
NumPad ←
StepNumPad ← /$"__"⧈(
  ∩(°¤⊚=NumPad)
  ⊃(∊:3_0⍜(⊢⍉)⇌⊟|Transition-)
  □⊂:@A⨬∘⇌
)⊂@A
$  ^A
$ <v>
⊜∘⊸≠@\n
DPad ←
StepDPad ← /$"__"⧈(
  ∩(°¤⊚=DPad)
  ⊃(∊:0_0⍜(⊢⍉)⇌⊟|Transition-)
  □⊂:@A⨬∘⇌
)⊂@A
$ 140A
$ 169A
$ 170A
$ 528A
$ 340A
⊜□⊸≠@\n
⊸⍚StepNumPad
⊃(↯∞_2⊞⊟."A<^>v"
  ⊃(∘|≡/+×⊓⊞(/+⌕⊙(◇⊂@A))(¤≡◇(⋕▽⊸≠@A)))
  ⟜≡(
    °⊟
    ∩(°¤⊚=DPad)
    ⊃(∊:0_0⍜(⊢⍉)⇌⊟|Transition-)
    □⊂:@A⨬∘⇌
  )
  ⍉⊞(/+⌕⊙(◇⊂@A))
  /+◌⍥₂₅⟜(/+×)
| ⍥₂(⍚StepDPad)
  /+≡(×◇⊓(⧻|⋕▽⊸≠@A)))
