(setq doom-theme 'gruber-darker)
;; (setq doom-theme 'tango)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'naysayer)
(menu-bar-mode -1)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 30 :weight 'light))
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq display-line-numbers-type 'relative)
(setq evil-normal-state-cursor 'box
      evil-insert-state-cursor 'box
      evil-visual-state-cursor 'box
      evil-replace-state-cursor 'box
      evil-motion-state-cursor 'box
      evil-emacs-state-cursor 'box)

(setq tab-width 4)
(setq insert-tabs-mode 'nil)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default evil-shift-width 4)

(defun my/switch-to-next-window-and-close ()
  "Switch to next window and then close it."
  (interactive)
  (other-window 1)
  (delete-window))

(map! :leader
      :desc "change window and kill it" "w d" #'my/switch-to-next-window-and-close)

;; fuzzy file search
(after! vertico
  (add-to-list 'completion-styles 'hotfuzz)
  (setq completion-category-overrides
        '((file (styles hotfuzz))))) ;; fuzzy file search

(remove-hook 'doom-first-buffer-hook #'global-flycheck-mode)
(setq evil-ex-search-highlight-all nil)
(remove-hook 'dired-mode-hook #'diredfl-mode)
(add-to-list 'default-frame-alist '(undecorated . t))

(map! :leader
      (:prefix ("e" . "edit config files")
       :desc "Edit scratch.c"    "j" (lambda () (interactive) (find-file "~/scratch/scratch.c"))
       :desc "Edit scratch.txt"  "k" (lambda () (interactive) (find-file "~/scratch/scratch.txt"))))

;; seperate clipboards
(setq select-enable-clipboard nil)
(setq select-enable-primary nil)
(map! "S-C-c" #'clipboard-kill-ring-save)
(map! "S-C-v" #'clipboard-yank)

;;;(setq select-enable-primary nil)
(map! :leader
      (:prefix ("e" . "files / dired")
       :desc "Open dired in ~/learning"
       "l" (lambda () (interactive) (dired "~/learning"))
       :desc "Open dired in ~/notes"
       "n" (lambda () (interactive) (dired "~/notes/programming/"))
       :desc "Open dired in ~/projects"
       "p" (lambda () (interactive) (dired "~/projects"))))

;; You can use this hydra menu that have all the commands
(map! :n "C-SPC" 'harpoon-quick-menu-hydra)
(map! :n "C-s" 'harpoon-add-file)

;; And the vanilla commands
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)


(defun my/duplicate_line ()
    (interactive)
    (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(map! :leader
      :desc "Duplicate line below, keep cursor"
      "["
      #'my/duplicate_line)

(defun my/yank-line-above (lines)
  "Yank line LINES above current line, keeping point position."
  (interactive "nLines above to yank: ")
  (let ((pos (point))
        (target-line (+ (line-number-at-pos) (- lines)))) ;; go lines above current line
    (when (> target-line 0)
      (save-excursion
        (goto-char (point-min))
        (forward-line (1- target-line))
        (kill-ring-save (line-beginning-position) (line-end-position))))
    (goto-char pos)))

(map! :leader
      :desc "Yank line above"
      "ya"
      #'my/yank-line-above)

(defun my/yank-line-below (lines)
  "Yank line LINES below current line, keeping point position."
  (interactive "nLines below to yank: ")
  (let ((pos (point))
        (target-line (+ (line-number-at-pos) lines)))
    (when (<= target-line (line-number-at-pos (point-max)))
      (save-excursion
        (goto-char (point-min))
        (forward-line (1- target-line))
        (kill-ring-save (line-beginning-position) (line-end-position))))
    (goto-char pos)))

(map! :leader
      :desc "Yank line above"
      "yb"
      #'my/yank-line-below)

(map! :leader
      :desc "Switch to alternate file" "SPC" #'evil-switch-to-windows-last-buffer)

(after! harpoon
  (setq harpoon-separate-by-branch nil)
  (setq harpoon-project-package nil)
  (setq harpoon-without-project-function #'+workspace-current-name))

(after! corfu
  (setq corfu-auto nil))

(after! evil-escape
  (setq evil-escape-key-sequence "jj")
  (setq evil-escape-delay 0.15))

(setq org-hide-emphasis-markers t)

(after! org
  (custom-set-faces!
    '(org-block
      :inherit fixed-pitch
      :background "#BBBBBB")
;;
;;    '(org-block-begin-line
;;      :inherit (shadow fixed-pitch)
;;      :background "#222222"
;;      :foreground "#888888")
;;    '(org-block-end-line
;;      :inherit (shadow fixed-pitch)
;;      :background "#222222"
;;      :foreground "#888888")
;;
    '(org-code
      :inherit fixed-pitch
;;      :background "#303030"
      :foreground "#4444FF")
    '(org-verbatim
      :inherit org-code)))

;; Custom function to create a dated Org file
(defun my/create-dated-org-file ()
  "Create a new Org file named after today's date (YYYY-MM-DD.org)
in the ~/journal directory."
  (interactive)
  (let* ((today (format-time-string "%d-%m-%Y"))
         (default-dir "~/journal/") ;; <--- CHANGED THIS PATH!
         (file-name (concat today ".org"))
         (full-path (expand-file-name file-name default-dir)))
    ;; Ensure the directory exists
    (unless (file-exists-p default-dir)
      (make-directory default-dir t))
    ;; Create or visit the file
    (find-file full-path)
    (message "Created/Opened %s" full-path)))

;;; Keybinding for the custom function
(map! :leader
      :desc "Create dated Org file"
      "ee" #'my/create-dated-org-file)

(map! :leader
      :desc "Switch Buffer"
      "dj" #'switch-to-buffer)

(setq initial-buffer-choice (lambda () (generate-new-buffer "*untitled*")))

(setq org-log-done t)
(setq compilation-window-height 18)

(add-hook 'c-mode-hook (lambda ()
                         (setq tab-width 4)
                         (setq c-basic-offset 4) ; Important for C-like modes
                         (setq indent-tabs-mode nil)))

(add-hook 'dired-mode-hook (lambda () (display-line-numbers-mode -1)))
;; ~/.doom.d/config.el

(map! :leader
      (:prefix ("d" . "development") ; This creates the 'd' prefix for development-related commands
       "l" #'compile             ; Maps SPC d l to the 'compile' command
       "k" #'recompile           ; Maps SPC d k to the 'recompile' command
       ))

(after! persp-mode
  (map! :leader
        :desc "Go to workspace 0" "TAB j" #'+workspace/switch-to-0
        :desc "Go to workspace 1" "TAB k" #'+workspace/switch-to-1
        :desc "Go to workspace 2" "TAB l" #'+workspace/switch-to-2
        :desc "Go to workspace 3" "TAB ;" #'+workspace/switch-to-3))

(with-eval-after-load 'dirvish
  (map! :leader
        :map dirvish-mode-map
        "mv" #'dirvish-move))
