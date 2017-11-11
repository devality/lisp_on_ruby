(
  (define (pascal row element)
    (cond ((or (= element 1) (= element row)) 1)
    ((and (> element 1) (< element row)) (+ (pascal (- row 1) (- element 1))
                                            (pascal (- row 1) element)))))
  (pascal 5 3)
)
