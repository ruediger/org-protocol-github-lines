;;; org-protocol-github-lines.el --- Open files and lines in emacs from your browser (when on github)

;; Copyright (C) 2012  Raimon Grau

;; Author: Raimon Grau <raimonster@gmail.com>
;; Keywords: tools, extensions

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'org-protocol)

(defgroup org-protocol-github nil
  "Browser to Emacs interface for GitHub"
  :prefix "org-protocol-github-"
  :group 'tools)

(defcustom org-protocol-github-projects nil
  "Map of GitHub projects to directories.
See also `org-protocol-github-project-directories'."
  :group 'org-protocol-github
  :type '(repeat (cons (string :tag "GitHub project name (user/project)")
                       (directory :tag "Project directory"))))


;;;###autoload
(defun org-protocol-github-comment (data)
  "Handle github-comment protocol.
DATA contains the user/project/file/line information."
  (let* ((content (org-protocol-split-data data t))
	 (key (format "%s/%s" (car content) (cadr content)))
	 (file (butlast (cddr content)))
	 (line (car (last content))))
    (message  "%s" content)
    (with-current-buffer
	(find-file (mapconcat 'identity
			      (cons (cadr (assoc key org-protocol-projects)) file) "/"))
      (goto-char (point-min))
      (forward-line (1- (string-to-number line)))))
  nil)

;;;###autoload
(add-to-list 'org-protocol-protocol-alist
             '("Github comment"
               :protocol "github-comment"
               :function org-protocol-github-comment))

(provide 'org-protocol-github-lines)
;;; org-protocol-github-lines.el ends here
