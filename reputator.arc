; start of something neat...

(= title* "reputator")
(= datadir* "data/") 

(def datadir (file)
  (string datadir* "/" file))

(deftem point
  for nil
  from nil
  val nil
  date nil)

(= pointfile* (datadir "points"))
(= points* (temloadall 'point pointfile*))

(def user? (name)
  (mem name (keys user->cookie*)))

(mac rep-page body
  `(whitepage
     (center
       (widtable 600
         (tag b (link title* "reputator"))
         (br 3)
         ,@body
         (br 3)
         (w/bars (link "users")
                 (link "scoreboard")
                 (link "about"))))))

(defop user req
  (aif (user? (arg req "name"))
       (user-page it)
       (not-found)))

(defop login req 
  (login-page 'both))

(def user-page (name)
  (rep-page 
    (pr name)))

(def user-points (name)
  (points*))

(def save-points ()
  (w/outfile of pointfile* (each x points* (write-table x of))))

(def add-point (to from val date)
  (= points* (cons (inst 'point 'to to 'from from 'val val 'date date) points*))
  (save-points))

(def not-found ()
  (rep-page 
    (pr "no such user.")))

(def rep-start ()
  (ensure-dir datadir*)
  (= srv* (asv)))

(def rep-stop ()
  (= quitsrv* t))