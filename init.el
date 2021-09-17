(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


(require 'use-package)
(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 10)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d/%d")
  (setq ivy-re-builders-alist
	`((t . ivy--regex-ignore-order))))

;;
;; counsel
;;
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("\C-x \C-f" . counsel-find-file)))

;;
;; swiper
;;
(use-package swiper
  :ensure t
  :bind (("\C-s" . swiper))
  )

(use-package go-mode
  ;; :load-path "~/.emacs.d/vendor/go-mode"
  :mode ("\\.go\\'" . go-mode)
  :init
  (setq gofmt-command "goimports"
        indent-tabs-mode t)
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  :bind (:map go-mode-map
              ("\C-c \C-c" . compile)
              ("\C-c \C-g" . go-goto-imports)
              ("\C-c \C-k" . godoc)
              ("M-j" . godef-jump)))

;;安装并配置go-autocomplete
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)
;; 设置为t表示忽略大小写，设置为nil表示区分大小写
;; 默认情况下为smart，表示如果输入的字符串不含有大写字符才会忽略大小写
(setq ac-ignore-case t)



(use-package helm-gtags
  :config
  (setq helm-gtags-ignore-case t
        helm-gtags-auto-update t
        helm-gtags-use-input-at-cursor t
        helm-gtags-pulse-at-cursor t
        helm-gtags-prefix-key "\C-cg"
        helm-gtags-suggested-key-mapping t)
  :bind (:map helm-gtags-mode-map
              ("C-c g a" . helm-gtags-tags-in-this-function)
              ("C-j" . helm-gtags-select)
                                        ;("M-." . helm-gtags-dwim)
                                        ;("M-," . helm-gtags-pop-stack)
              ("C-c <" . helm-gtags-previous-history)
              ("C-c >" . helm-gtags-next-history))
  :hook ((dired-mode eshell-mode c-mode c++-mode asm-mode go-mode) . helm-gtags-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(atom-one-dark))
 '(custom-safe-themes
   '("5a04c3d580e08f5fc8b3ead2ed66e2f0e5d93643542eec414f0836b971806ba9" "171d1ae90e46978eb9c342be6658d937a83aaa45997b1d7af7657546cae5985b" "5b7c31eb904d50c470ce264318f41b3bbc85545e4359e6b7d48ee88a892b1915" default))
 '(package-selected-packages
   '(idea-darkula-theme atom-one-dark-theme atom-dark-theme color-theme tabbar dumb-jump helm-gtags use-package go-mode go-autocomplete counsel company))
 '(session-use-package t nil (session))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(menu-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-message t);关闭启动画面
(global-hl-line-mode 1);highlight当前行
(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
                                        ;  (setq dumb-jump-selector 'ivy)
                                        ; (setq dumb-jump-selector 'helm)
  (dumb-jump-mode)
  :ensure
  )

;; Godef jump key binding
                                        ;(global-set-key (kbd "M-,") 'godef-jump)
(global-set-key (kbd "M-,") 'dumb-jump-go)
(global-set-key (kbd "M-.") 'dumb-jump-back)


(setq make-backup-files nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;org-mode
;;关于org模式的额外优化
;;https://github.com/lujun9972/emacs-document/blob/master/org-mode/%E7%BE%8E%E5%8C%96%20Org%20mode.org
(setq org-startup-indented t
      org-src-tab-acts-natively t)

(setq org-list-demote-modify-bullet
      (quote (("+" . "-")
              ("-" . "+")
              ("*" . "-")
              ("1." . "-")
              ("1)" . "-")
              ("A)" . "-")
              ("B)" . "-")
              ("a)" . "-")
              ("b)" . "-")
              ("A." . "-")
              ("B." . "-")
              ("a." . "-")
              ("b." . "-"))))
(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-ellipsis "⤵")
  :hook (org-mode . org-bullets-mode))


(defun now ()
  "在当前buffer中插入时间"
  (interactive)
  ( insert (current-time-string)))

(set-frame-font "Simsun 18")



;解决emacs shell 乱码
(setq ansi-color-for-comint-mode t)
(customize-group 'ansi-colors)
(kill-this-buffer);关闭customize窗口

(setq visible-bell t);关闭出错时的提示声
(setq make-backup-files nil);不产生备份文件
(setq default-major-mode 'text-mode);一打开就起用 text 模式
(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode nil);去掉那个大大的工具栏
(set-scroll-bar-mode nil);去掉滚动条
;(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq frame-title-format '("" buffer-file-name "@emacs" ));在标题栏显示buffer名称
(setq default-fill-column 80);默认显示 80列就换行 


;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)




;加入会话功能
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(load "desktop")
(desktop-save-mode)


;加入标签页功能
(require 'tabbar)
(tabbar-mode)
;(global-set-key (kbd "") 'tabbar-backward-group)
;(global-set-key (kbd "") 'tabbar-forward-group)
(global-set-key (kbd "C-`") 'tabbar-backward)
(global-set-key (kbd "C-<tab>") 'tabbar-forward)


;;Reference
;;https://forum.ubuntu.org.cn/viewtopic.php?t=62416
