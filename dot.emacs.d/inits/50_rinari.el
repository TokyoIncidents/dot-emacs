;;rinari
;; C-c ' がprefixキー
(setq rinari-minor-mode-prefixes (list "'"))
(require 'rinari)

;;; rhtml-mode
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))

;;.emacs
(setq rails-tags-dirs '("app" "lib" "test" "db" "vendor"))
(require 'rinari-extend-by-emacs-rails)
(defun ruby-mode-hooks-rinari-extend ()
  (define-key ruby-mode-map (kbd "<C-f1>") 'rails-search-doc)
  (define-key ruby-mode-map [f1] 'rails-search-doc-at-point)
)
(defun rinari-mode-hooks-rinari-extend ()
  (define-key rinari-minor-mode-map "\C-c\C-t" 'rails-create-tags)
)
(add-hook 'ruby-mode-hook 'ruby-mode-hooks-rinari-extend)
(add-hook 'rinari-mode-hook 'rinari-mode-hooks-rinari-extend)

;; http://d.hatena.ne.jp/gan2/20080702/1214972962
;; flymake for ruby
(require 'flymake)
;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode))
    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))