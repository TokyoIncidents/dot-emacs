;; http://www.nongnu.org/baol-hth/
;; https://gist.github.com/672655
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)

(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.ejs$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tx$" . html-helper-mode) auto-mode-alist))

(setq html-helper-basic-offset 4)
(setq html-helper-item-continue-indent 0)
(setq html-helper-never-indent t)
(setq html-helper-verbose nil)

(defvar html-helper-new-buffer-template
  '("<!DOCTYPE html>\n"
    "<html lang=\"ja\">\n"
    "\n"
    "<head>\n"
    "<meta charset=\"utf-8\">\n"
    "<title></title>\n"
    "</head>\n"
    "\n"
    "<body>\n"
    "\n"
    "\n"
    "\n"
    "</body>\n"
    "</html>\n")
  "*Template for new buffers, inserted by html-helper-insert-new-buffer-strings if html-helper-build-new-buffer is set to t")

(require 'sgml-mode)
(add-hook 'html-helper-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-e") 'sgml-close-tag)
             (set-face-bold-p 'html-tag-face nil)))
