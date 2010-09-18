/set status_ext_tf_version=
/set status_ext_tf_author=Asuka@mg.mud.de
/set status_ext_tf_requires=util.tf
/set status_ext_tf_desc=Ergaenzung zur Statuszeile

/set pedantic off
/set diff 0
/set leben 210


/def -ag -F -mregexp -p9999 -t'^Du hast jetzt (.*) Lebenspunkte und (.*) \
          Konzentrationspunkte\\.$' warok_status = \
          /if ({P1} < {leben}) /eval /echo -ahCred LP: $[{P1} - {leben}]%;\
              /set diff  $[({P1} - {leben}) * -1]%;\
          /endif%;\
         /set leben %P1

