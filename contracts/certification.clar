;; Certification Contract
;; Issues verification of disaster-resistant standards

;; Import other contracts
;; Note: In a real implementation, we would use contract-call? to interact with other contracts
;; For simplicity, we're assuming direct access to the data

(define-map certifications
  { building-id: uint }
  {
    certified: bool,
    certification-date: (optional uint),
    certifier: (optional principal),
    expiration-date: (optional uint),
    resistance-level: uint,
    hazard-types: (list 10 (string-utf8 50))
  }
)

;; Issue a certification for a building
(define-public (issue-certification
                (building-id uint)
                (resistance-level uint)
                (hazard-types (list 10 (string-utf8 50)))
                (expiration-blocks (optional uint)))
  (begin
    ;; In a real implementation, we would:
    ;; 1. Check if tx-sender is an authorized certifier
    ;; 2. Verify that all materials are verified
    ;; 3. Verify that all techniques are implemented correctly

    (let ((expiration (match expiration-blocks
                        value (some (+ block-height value))
                        none)))

      (map-set certifications
        { building-id: building-id }
        {
          certified: true,
          certification-date: (some block-height),
          certifier: (some tx-sender),
          expiration-date: expiration,
          resistance-level: resistance-level,
          hazard-types: hazard-types
        }
      )

      (ok true)
    )
  )
)

;; Revoke a certification
(define-public (revoke-certification (building-id uint))
  (let ((certification (unwrap! (map-get? certifications { building-id: building-id }) (err u1))))

    ;; Only the original certifier can revoke
    (asserts! (is-eq (some tx-sender) (get certifier certification)) (err u2))

    (map-set certifications
      { building-id: building-id }
      (merge certification { certified: false })
    )

    (ok true)
  )
)

;; Check if a certification is valid
(define-read-only (is-certification-valid (building-id uint))
  (match (map-get? certifications { building-id: building-id })
    certification (and
                    (get certified certification)
                    (match (get expiration-date certification)
                      expiry (< block-height expiry)
                      true))
    false)
)

;; Get certification details
(define-read-only (get-certification (building-id uint))
  (map-get? certifications { building-id: building-id })
)

;; Check if a building is certified for a specific hazard type
(define-read-only (is-certified-for-hazard (building-id uint) (hazard-type (string-utf8 50)))
  (match (map-get? certifications { building-id: building-id })
    certification (and
                    (get certified certification)
                    (is-some (index-of (get hazard-types certification) hazard-type))
                    (match (get expiration-date certification)
                      expiry (< block-height expiry)
                      true))
    false)
)
