(define (domain Dungeon)

    (:requirements :typing :negative-preconditions :conditional-effects :equality)

    ; Do not modify the types
    (:types
        location colour key corridor
    )

    ; Do not modify the constants
    (:constants
        red yellow green purple rainbow - colour
    )

    ; You may introduce whatever predicates you would like to use
    (:predicates
        (hero-at ?loc - location)
        (connected ?from ?to - location ?cor - corridor)
        (corridor-unlocked ?cor - corridor)
        (corridor-risky ?cor - corridor)
        (corridor-collapsed ?cor - corridor)
        (corridor-locked ?cor - corridor ?col - colour)  ; Correctly using corridor-locked
        (key-at ?k - key ?loc - location)
        (hero-holding ?k - key)
        (key-color ?k - key ?col - colour)
        (location-messy ?loc - location)
        (arm-free)

        ; Key usage states (Instead of numerical fluents)
        (one-use ?k - key)
        (two-uses ?k - key)
        (multi-use ?k - key)
        (used-up ?k - key)
    )

    ; Hero can move if the
    ;    - hero is at current location ?from,
    ;    - hero will move to location ?to,
    ;    - corridor ?cor exists between the ?from and ?to locations
    ;    - there isn't a locked door in corridor ?cor
    ; Effects move the hero, and collapse the corridor if it's "risky" (also causing a mess in the ?to location)
    (:action move
        :parameters (?from ?to - location ?cor - corridor)
        :precondition (and
            (hero-at ?from)
            (connected ?from ?to ?cor)
            (not (exists (?col - colour) (corridor-locked ?cor ?col))) ; Corrected: using corridor-locked
            (not (corridor-collapsed ?cor))
        )
        :effect (and
            (not (hero-at ?from))
            (hero-at ?to)
            (when
                (corridor-risky ?cor)
                (and (not (corridor-unlocked ?cor))
                    (corridor-collapsed ?cor)
                    (location-messy ?to)))
        )
    )

    ; Hero can pick up a key if the
    ;    - hero is at current location ?loc,
    ;    - there is a key ?k at location ?loc,
    ;    - the hero's arm is free,
    ;    - the location is not messy
    ; Effect will have the hero holding the key and their arm no longer being free
    (:action pick-up
        :parameters (?loc - location ?k - key)
        :precondition (and
            (hero-at ?loc)
            (key-at ?k ?loc)
            (arm-free)
            (not (location-messy ?loc))
        )
        :effect (and
            (not (key-at ?k ?loc))
            (hero-holding ?k)
            (not (arm-free))
            ;; Preserve key usage properties
            (when (one-use ?k) (one-use ?k))
            (when (two-uses ?k) (two-uses ?k))
            (when (multi-use ?k) (multi-use ?k))
        )
    )

    ; Hero can drop a key if the
    ;    - hero is holding a key ?k,
    ;    - the hero is at location ?loc
    ; Effect will be that the hero is no longer holding the key
    (:action drop
        :parameters (?loc - location ?k - key)
        :precondition (and
            (hero-at ?loc)
            (hero-holding ?k)
        )
        :effect (and
            (not (hero-holding ?k))
            (arm-free)
            (key-at ?k ?loc)
        )
    )

    ; Hero can use a key for a corridor if
    ;    - the hero is holding a key ?k,
    ;    - the key still has some uses left,
    ;    - the corridor ?cor is locked with colour ?col,
    ;    - the key ?k is of the right colour ?col,
    ;    - the hero is at location ?loc
    ;    - the corridor is connected to the location ?loc
    ; Effect will be that the corridor is unlocked and the key usage will be updated if necessary
    (:action unlock
        :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)
        :precondition (and
            (hero-at ?loc)
            (hero-holding ?k)
            (key-color ?k ?col)
            (corridor-locked ?cor ?col)
            (exists (?other-loc - location) (connected ?loc ?other-loc ?cor))  ;; Ensure ?loc connects to a valid location
            (or (one-use ?k) (two-uses ?k) (multi-use ?k))
        )
        :effect (and
            (not (corridor-locked ?cor ?col))
            (corridor-unlocked ?cor)
            ;; Handle different key use cases
            (when (two-uses ?k) (and (not (two-uses ?k)) (one-use ?k)))
            (when (one-use ?k) (and (not (one-use ?k)) (used-up ?k)))
        )
    )


    ; Hero can clean a location if
    ;    - the hero is at location ?loc,
    ;    - the location is messy
    ; Effect will be that the location is no longer messy
    (:action clean
        :parameters (?loc - location)
        :precondition (and
            (hero-at ?loc)
            (location-messy ?loc)
        )
        :effect (not (location-messy ?loc))
    )

)
