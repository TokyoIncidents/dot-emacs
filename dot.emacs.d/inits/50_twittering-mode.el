(require 'twittering-mode)

;; http://www.mew.org/~kazu/proj/cipher/ja/
;; (install-elisp "http://www.mew.org/~kazu/proj/cipher/alpaca.el")
(autoload 'alpaca-after-find-file "alpaca" nil t)  
(add-hook 'find-file-hooks 'alpaca-after-find-file)

(setq twittering-use-master-password t)
