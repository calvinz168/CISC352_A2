(define (problem p4-dungeon)
  (:domain Dungeon)

  ; Come up with your own problem instance (see assignment for details)
  ; NOTE: You _may_ use new objects for this problem only.

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-1-1 loc-1-2 loc-1-3 loc-2-1 loc-2-2 loc-2-3 loc-3-1 loc-3-2 loc-4-1 - location
    c1112 c1121 c1213 c1323 c2122 c2131 c2231 c2232 c3141 c3132 - corridor
    key1 key2 key3 key4 key5 key6 key7 - key
  )

  (:init

    ; Hero location and carrying status
    (hero-at loc-2-2)

    ; Locations <> Corridor Connections
    (connected loc-1-1 loc-1-2 c1112)
    (connected loc-1-2 loc-1-1 c1112)

    (connected loc-1-1 loc-2-1 c1121)
    (connected loc-2-1 loc-1-1 c2122)
    
    (connected loc-1-2 loc-1-3 c1213)
    (connected loc-1-3 loc-1-2 c1213)

    (connected loc-1-3 loc-2-3 c1323)
    (connected loc-2-3 loc-1-3 c1323)

    (connected loc-2-1 loc-2-2 c2122)
    (connected loc-2-2 loc-2-1 c2122)

    (connected loc-2-1 loc-3-1 c2131)
    (connected loc-3-1 loc-2-1 c2131)

    (connected loc-2-2 loc-3-1 c2231)
    (connected loc-3-1 loc-2-2 c2231)

    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-2-2 c2232)

    (connected loc-3-1 loc-4-1 c3141)
    (connected loc-4-1 loc-3-1 c3141)

    (connected loc-3-1 loc-3-2 c3132)
    (connected loc-3-2 loc-3-1 c3132)

    ; Key locations
    (key-at key1 loc-1-2)
    (key-at key2 loc-2-1)
    (key-at key3 loc-3-1)
    (key-at key4 loc-3-1)
    (key-at key5 loc-4-1)
    (key-at key6 loc-3-2)
    (key-at key7 loc-4-1)

    ; Locked corridors
    (corridor-locked c1213 red)
    (corridor-locked c1112 green)
    (corridor-locked c1323 rainbow)
    (corridor-locked c1121 yellow)
    (corridor-locked c2131 red)
    (corridor-locked c2231 red)
    (corridor-locked c2232 yellow)
    (corridor-locked c3132 purple)
    (corridor-locked c3141 purple)

    ; Risky corridors
    (corridor-risky c2131)
    (corridor-risky c2231)
    (corridor-risky c1213)

    ; Key colours
    (key-color key1 purple)
    (key-color key2 red)
    (key-color key3 yellow)
    (key-color key4 red)
    (key-color key5 red)
    (key-color key6 green)
    (key-color key7 rainbow)

    ; Key usage properties (one use, two use, etc)
    (multi-use key1)
    (one-use key2)
    (multi-use key3)
    (one-use key4)
    (one-use key5)
    (multi-use key6)
    (one-use key7)

    ; Hero starts not holding anything
    (arm-free)

  )
  (:goal
    (and
      ; Hero's final location goes here
      (hero-at loc-2-3) ; Hero reaches the treasure room
    )
  )

)
