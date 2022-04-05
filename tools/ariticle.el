(require 'subr-x)

(defun title(input) ""
         (let* (
                (words (split-string input))
                (first (pop words))
                (last (car(last words)))
                (do-not-capitalize '("the" "of" "from" "and" "yet" "in" "Was" "As" "Over" "From" "So" "In" "Of" "And" "On" "With" "By" "Under" "To" "About" "At" "For" "Or" "Is" "The" "A" "This" "Nearly")))
           (insert (format "\n%s\n" (concat (capitalize first)
                   " "
                   (mapconcat (lambda (w)
                                (if (not(member (downcase w) (mapcar 'downcase do-not-capitalize)))
                                    (capitalize w)(downcase w)))
                              (butlast words) " ")
                   " " (capitalize last))))))



(defun author(input)
 (mapcar (lambda(item) (insert (format "\n%s" (string-trim  (replace-regexp-in-string  "[0-9]+" "" item))))) (split-string input ",")))


