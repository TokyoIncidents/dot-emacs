;; server
(server-start)

;; PATH
;; http://d.hatena.ne.jp/syohex/20111117/1321503477
;;
;; add script below to .zshrc
;; <script>
;; perl -wle \
;;     'do { print qq/(setenv "$_" "$ENV{$_}")/ if exists $ENV{$_} } for @ARGV' \
;;     PATH > ~/.emacs.d/shellenv.el
;; </script>
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH") ":")))
  (add-to-list 'exec-path path))

;; mail address
(setq user-mail-address "tokyoincidents.g@gmail.com")

;; meta & super key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; don't save backup files
(setq make-backup-files nil)

;; inhibit bell ring
(setq ring-bell-function 'ignore)

;; scroll settings
(setq scroll-step 1)

;; display column number
(column-number-mode t)

;; inhibit truncate
(setq-default truncate-lines nil)
(setq-default truncate-partial-width-windows t)

;; indent settings
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq-default tab-width 4)
(c-set-offset 'case-label '+)

;; enable narrowing
(put 'narrow-to-region 'disabled nil)

;; hide startup message
(setq inhibit-startup-message t)

;; set time local
(setq system-time-locale "C")

;; change default grep command to ack
;; http://d.hatena.ne.jp/sugyan/20100604/1275587743
(grep-apply-setting 'grep-command "ack --nogroup")

;; Displays the time in the mode line
(setq display-time-format "%Y-%m-%d (%a) %H:%M")
(display-time)
