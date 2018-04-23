(defsystem pdf-searcher-test
  :name "pdf-searcher-test"
  :defsystem-depends-on (:prove-asdf)
  :depends-on (:pdf-searcher
	       :prove)
  :components ((:module "tests"
		:components
		((:test-file "pdf-searcher"))))
  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
