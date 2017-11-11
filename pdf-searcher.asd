(in-package :cl-user)
(defpackage pdf-searcher-asd
  (:use :cl :asdf))
(in-package :pdf-searcher-asd)

(defsystem pdf-searcher
  :name "pdf-searcher"
  :description ""
  :depends-on (:inferior-shell
	       :cl-ppcre)
  :components ((:file "pdf-searcher")))
