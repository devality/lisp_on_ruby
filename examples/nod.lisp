(
 (define (gcd a b)
   (if (= b 0)
     a
     (gcd b (% a b)))
   )
 (gcd 206 40)
 )

