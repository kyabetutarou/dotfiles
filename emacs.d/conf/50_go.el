;; ==================================================
;; GO SETTING
;; ==================================================

;; --------------------------------------------------
;; Go mode 
;; --------------------------------------------------
(require 'go-mode nil t)


;; --------------------------------------------------
;; Using command instal by go get
;; --------------------------------------------------
(add-to-list 'exec-path (expand-file-name "~/dev/go/bin"))


;; --------------------------------------------------
;; Arrange source code before saving
;; --------------------------------------------------
(add-hook 'before-save-hook 'gofmt-before-save)


;; --------------------------------------------------
;; Keybind
;; --------------------------------------------------
(defun go-keybind ()
  (local-set-key (kbd "M-j")      'godef-jump)      ;; Jump to definition
  (local-set-key (kbd "\C-c")     'go-import-add)   ;; Import package
  )

(add-hook 'go-mode-hook 'go-keybind)


;; --------------------------------------------------
;; Complete
;; --------------------------------------------------
(add-to-list 'load-path "~/dev/go/src/github.com/nsf/gocode/emacs/")
(require 'go-autocomplete nil t)
(require 'auto-complete-config nil t)


;; --------------------------------------------------
;; Flymake
;; --------------------------------------------------
(add-to-list 'load-path "~/dev/go/src/github.com/dougm/goflymake")
(require 'go-flymake nil t)


;; --------------------------------------------------
;; Eldoc, show arguments type
;; --------------------------------------------------
(require 'go-eldoc nil t)
(add-hook 'go-mode-hook 'go-eldoc-setup)


;; --------------------------------------------------
;; smartchr
;; --------------------------------------------------

(require 'smartchr nil t)

(defun smartchr-go ()
  (local-set-key (kbd "+") (smartchr '("+" " + " " += " " ++ ")))
  (local-set-key (kbd "-") (smartchr '("-" " - " " -= " " -- ")))
  (local-set-key (kbd "=") (smartchr '("=" " = " " := ")))
  (local-set-key (kbd ";") (smartchr '("; " ";")))
  (local-set-key (kbd ">") (smartchr '(" > " " -> " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <- " "<")))  
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{\n`!!'\n}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  )

(add-hook 'go-mode-hook 'smartchr-go)

