#|
@doc
  Telegram low-level API library for LFE
@end
|#

(defmodule telex
  (export (request 2)
          (request 3)))

;;; API

(defun request [token method]
  (request token method #M()))

(defun request [token method opts]
  (let [(req-opts (parse-keyboard opts))]
    (if (has-files? req-opts)
      (do-request token method (multipart-body req-opts))
      (do-request token method req-opts))))

;;; Internal functions

(defun do-request [token method body]
  (let* [(action 'post)
         (url (create-url token method))
         (headers (create-headers))
         (payload (jsone:encode body))
         (options [])]
  (dispatch-request action url headers payload options)))

(defun has-files? [opts]
  'false)

(defun parse-keyboard [opts]
  opts)

(defun multipart-body [opts]
  'ok)

(defun dispatch-request [method url headers payload options]
  (case (hackney:request method url headers payload options)
    (`#(ok ,_ ,_headers ,ref)
     (let* [(`#(ok ,body) (hackney:body ref))
            (decoded (jsone:decode body))]
       (if (maps:get #"ok" decoded)
         `#(ok ,(maps:get #"result" decoded))
         `#(error ,(maps:get #"description" decoded)))))
    (error error)))

(defun create-url [token method]
  (erlang:iolist_to_binary
   `[#"https://api.telegram.org/bot" ,token "/" ,method]))

(defun create-headers []
  `[#(#"content-type" #"application/json")])