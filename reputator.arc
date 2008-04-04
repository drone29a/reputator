; start of something neat...

(= datadir* "data/" users* (table))
(= title* "reputator")

(deftem user
  name nil
  passwd nil)

(def user (name) (users* name))

(mac rep-page body
  `(whitepage
     (center
       (widtable 600
         (tag b (link title* "reputator"))
         (br 3)
         ,@body
         (br 3)
         (w/bars (link "users")
                 (link "+/-1"))))))

(defop view req
  (aif (user (arg req "user"))
       (user-page it)
       (not-found)))

(def user-page (user)
  (pr user))

(def not-found ()
  (rep-page (pr "no such user.")))

(def go-rep ()
  (ensure-dir datadir*)
  (asv))