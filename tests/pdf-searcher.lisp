(in-package :cl-user)
(defpackage :pdf-searcher-test
  (:use
   :cl
   :pdf-searcher
   :prove))
(in-package :pdf-searcher-test)

(setf *enable-colors* nil)

(defun test-pdf (name)
  (namestring
   (reduce #'merge-pathnames (list name "tests/")
	   :from-end t
	   :initial-value (asdf:component-pathname
			   (asdf:find-system "pdf-searcher")))))

;; NOTE: To run this test file, execute `(asdf:test-system :pdf-searcher)' in your Lisp.

(plan 5)

(is-values (find-pdf-files-with-mentions (test-pdf "pdf/*") "test")
	   `((,(test-pdf "pdf/test1.pdf") ,(test-pdf "pdf/test2.pdf")) nil))

(is-values (find-pdf-files-with-mentions (test-pdf "pdf/test1.pdf") "test")
	   `((,(test-pdf "pdf/test1.pdf") ,(test-pdf "pdf/test2.pdf")) nil))

(is-values (find-pdf-files-with-mentions (test-pdf "pdf/*") "test1")
	   `((,(test-pdf "pdf/test1.pdf")) (,(test-pdf "pdf/test2.pdf"))))

(is-values (find-pdf-files-with-mentions (test-pdf "pdf/*") "test3")
	   `(nil (,(test-pdf "pdf/test1.pdf") ,(test-pdf "pdf/test2.pdf"))))

(is-error (find-pdf-files-with-mentions (test-pdf "pdf/test3.pdf") "test")
	  'type-error)

(finalize)
  
