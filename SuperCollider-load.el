(add-to-list 'load-path "~/.emacs.d/personal/emacsconfig/el")
(load-file "~/.emacs.d/personal/emacsconfig/el/sclang.el")
;;(load-file "~/.emacs.d/personal/sc-snippets.el")

(require 'sclang)

;; (require 'w3m)

;; (eval-after-load "w3m"
;;   '(progn
;;      (define-key w3m-mode-map [left] 'backward-char)
;;      (define-key w3m-mode-map [right] 'forward-char)
;;      (define-key w3m-mode-map [up] 'previous-line)
;;      (define-key w3m-mode-map [down] 'next-line)))

(defvar sc_userAppSupportDir
  (  expand-file-name "~/Library/Application Support/SuperCollider" ))

(add-to-list
 'exec-path
 "/Applications/SuperCollider/SuperCollider.app/Contents/MacOS/")

(global-set-key (kbd "C-c M-s") 'sclang-start)
(global-set-key (kbd "C-c W") 'sclang-switch-to-workspace)

(setq sclang-show-workspace-on-startup 1)

;;(add-hook 'sclang-mode-hook 'yas-minor-mode )
;;(add-hook 'sclang-mode-hook 'smartparens-mode )

;; org babel sclang
;;-----------------------------------------------------------------------
 (require 'org)
 (require 'ob)

 (require 'sclang-interp)

 (defgroup ob-sclang nil
   "org-mode blocks for SuperCollider SCLang."
   :group 'org)

 ;;;###autoload
 (defun org-babel-execute:sclang (body params)
   "Org-mode Babel sclang hook for evaluate `BODY' with `PARAMS'."
   (unless (or (equal (buffer-name) sclang-post-buffer)
               (sclang-get-process))
     (sclang-start))

   (sclang-eval-string body t)

   ;; (let ((cmd "sclang -r -s -D"))
   ;;   (org-babel-eval cmd body))
   )

 (defvar org-babel-default-header-args:sclang nil)

 (setq org-babel-default-header-args:sclang
       '((:session . "*SCLang:Workspace*")
         (:output . "none")) ; TODO: temporary can't find way to let sclang output to stdout for org-babel.
       )

 ;;;###autoload
 (with-eval-after-load "org"
   (add-to-list 'org-src-lang-modes '("sclang" . sclang)))

 ;;; ----------------------------------------------------------------------------

 (provide 'ob-sclang)

 ;;; ob-sclang.el ends here
