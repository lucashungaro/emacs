(server-start)

(push "/usr/local/bin" exec-path)

(setq running-osx (or (featurep 'mac-carbon) (eq 'ns window-system)))

(if (and running-osx (not (member "/Users/lucashungaro/bin" exec-path)))
    (let* ((path   (shell-command-to-string "/bin/bash -lc 'echo -n $PATH'"))
           (cdpath (shell-command-to-string "/bin/bash -lc 'echo -n $CDPATH'"))
           (path-list (split-string path ":" t)))
      (setenv "PATH" path)
      (setenv "CDPATH" cdpath)
      (dolist (p path-list) (add-to-list 'exec-path p t))))

(setq make-backup-files nil)
(setq auto-save-default nil)

(delete-selection-mode t)
(blink-cursor-mode t)
(show-paren-mode t)

(load-file "~/.emacs.d/elpa-to-submit/color-theme-molokai.el")
(color-theme-molokai)

(load-file "~/.emacs.d/visual-bell.el")

(global-linum-mode)

(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet-0.6.1c/snippets")

(add-hook 'rspec-mode-hook
	  #'(lambda ()
	      (setq yas/mode-symbol 'rspec-mode)))


(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'peepopen)
(require 'textmate)
(textmate-mode)
;; always open in the same window
(setq ns-pop-up-frames nil)

(add-to-list 'load-path "~/.emacs.d/vendor/rvm.el")
(require 'rvm)
;; use rvm’s default ruby for the current Emacs session
(rvm-use-default) 

(require 'rinari)

;;mode-compile
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

(require 'rspec-mode)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell 
      (replace-regexp-in-string "[[:space:]\n]*$" "" 
        (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

(set-face-attribute 'default nil :height 140)
(set-frame-font "-apple-Monaco-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1400)
        (add-to-list 'default-frame-alist (cons 'width 190))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
                 (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)
