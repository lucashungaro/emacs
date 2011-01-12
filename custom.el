(server-start)

(load-file "~/.emacs.d/elpa-to-submit/color-theme-almost-monokai.el")
(color-theme-almost-monokai)

(load-file "~/.emacs.d/visual-bell.el")

(add-to-list 'load-path "~/.emacs.d/vendor/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/vendor/yasnippet-0.6.1c/snippets")

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

(set-face-attribute 'default nil :height 140)
(set-default-font "-apple-Monaco-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
        (add-to-list 'default-frame-alist (cons 'width 160))
      (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist 
                 (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)
