(in-package :cl-user)
(defpackage :pdf-searcher
  (:use
   :cl)
  (:import-from
   :inferior-shell
   :run/s)
  (:import-from
   :cl-ppcre
   :scan
   :create-scanner)
  (:export
   :find-pdf-files-with-mentions))

					;(ql:quickload :plump)
					;(children (plump:parse (get-file-as-string "d:/WorkFiles/ifs_component_dependency_visualizer/Sample/sample.graphml")))

(in-package :pdf-searcher)

(defun find-pdf-files-with-mentions (root-pathname search-string)
  "
Searches all pdf files recrursively under the root-pathname provided, and returns the list of files which has the search-string specified. The second value returned is a list of files which was determined to be unreadable. Uses pdftotext linux tool.
"
  (labels ((collect-directories (unchecked-directories directory-list)
	     (if (not (car unchecked-directories))
		 directory-list
		 (collect-directories (append (cdr unchecked-directories)
					      (directory (concatenate 'string
								      (directory-namestring (car unchecked-directories))
								      "*")))
				      (append directory-list (list (car unchecked-directories)))))))
    (values-list
     (loop for pdf-file in (apply #'append
				  (loop for pdf-dir in (collect-directories
							(if (wild-pathname-p root-pathname)
							    (directory root-pathname)
							    (directory (concatenate
									'string
									(directory-namestring
									 (car (directory root-pathname)))
									"*")))
							'())
					collect (directory
						 (concatenate 'string
							      (directory-namestring pdf-dir)
							      "*.pdf"))))
					;for i from 0 upto 1
	   ;do (print (pathname-directory pdf-file))
	   if (scan
	       (create-scanner (list :sequence
				     :case-insensitive-p
				     search-string
				     :case-insensitive-p))
	       (run/s (concatenate 'string
				   "pdftotext \""
				   (namestring pdf-file)
				   "\" -")
		      :on-error nil))
	     collect (namestring pdf-file) into found
	   else if (null (scan
			  (create-scanner (list :sequence
						:case-insensitive-p
						(list :alternation "abstract" "reference")
						:case-insensitive-p))
			  (run/s (concatenate 'string
					      "pdftotext \""
					      (namestring pdf-file)
					      "\" -")
				 :on-error nil)))
		  collect (namestring pdf-file) into unreadable
	   finally
	      (return (list found unreadable))))))
