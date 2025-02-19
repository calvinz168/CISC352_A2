(define (problem p1-dungeon)
  (:domain Dungeon)

  ; Naming convention:
  ; - loc-{i}-{j} refers to the location at the i'th column and j'th row (starting in top left corner)
  ; - c{i}{j}{h}{k} refers to the corridor connecting loc-{i}-{j} and loc-{h}-{k}
  (:objects
    loc-3-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 loc-3-3 loc-2-4 loc-3-4 loc-4-4 - location
    key1 key2 key3 key4 - key
    c3132 c1222 c2232 c3242 c2223 c3233 c2333 c2324 c3334 c2434 c3444 - corridor
  )

  (:init
    ; Hero starts at loc-1-2
    (hero-at loc-1-2)

    ; Locations connected by corridors (bidirectional)
    (connected loc-3-1 loc-3-2 c3132)
    (connected loc-3-2 loc-3-1 c3132)  ; Reverse connection

    (connected loc-1-2 loc-2-2 c1222)
    (connected loc-2-2 loc-1-2 c1222)  ; Reverse connection
    (connected loc-2-2 loc-3-2 c2232)
    (connected loc-3-2 loc-2-2 c2232)  ; Reverse connection

    (connected loc-3-2 loc-4-2 c3242)
    (connected loc-4-2 loc-3-2 c3242)  ; Reverse connection

    (connected loc-2-2 loc-2-3 c2223)
    (connected loc-2-3 loc-2-2 c2223)  ; Reverse connection

    (connected loc-3-2 loc-3-3 c3233)
    (connected loc-3-3 loc-3-2 c3233)  ; Reverse connection

    (connected loc-2-3 loc-3-3 c2333)
    (connected loc-3-3 loc-2-3 c2333)  ; Reverse connection

    (connected loc-2-3 loc-2-4 c2324)
    (connected loc-2-4 loc-2-3 c2324)  ; Reverse connection

    (connected loc-3-3 loc-3-4 c3334)
    (connected loc-3-4 loc-3-3 c3334)  ; Reverse connection

    (connected loc-2-4 loc-3-4 c2434)
    (connected loc-3-4 loc-2-4 c2434)  ; Reverse connection

    (connected loc-3-4 loc-4-4 c3444)
    (connected loc-4-4 loc-3-4 c3444)  ; Reverse connection

    ; Key locations
    (key-at key1 loc-2-2)
    (key-at key2 loc-2-4)
    (key-at key3 loc-4-2)
    (key-at key4 loc-4-4)

    ; Locked corridors
    (corridor-locked c3242 purple)
    (corridor-locked c3444 yellow)
    (corridor-locked c3132 rainbow)
    (corridor-locked c2324 red)
    (corridor-locked c2434 red)

    ; Risky corridors
    (corridor-risky c2324)
    (corridor-risky c2434)

    ; Key colours
    (key-color key1 red)
    (key-color key2 yellow)
    (key-color key3 rainbow)
    (key-color key4 purple)

    ; Key usage properties
    (multi-use key1)
    (two-uses key2)
    (one-use key3)
    (one-use key4)

    ; Not holding anything
    (arm-free)
  )

  (:goal
    (and
      (hero-at loc-3-1) ; Hero reaches the treasure room
    )
  )
)
