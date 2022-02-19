#!/bin/bash

# inbox
r_in=$(mu find maildir:/r/INBOX 2>/dev/null | wc -l)
q_in=$(mu find maildir:/q/INBOX 2>/dev/null | wc -l)
e_in=$(mu find maildir:/e/INBOX 2>/dev/null | wc -l)

# inbox unread
r_in_unread=$(mu find maildir:/r/INBOX flag:unread 2>/dev/null | wc -l)
q_in_unread=$(mu find maildir:/q/INBOX flag:unread 2>/dev/null | wc -l)
e_in_unread=$(mu find maildir:/e/INBOX flag:unread 2>/dev/null | wc -l)

r_in_unread_text=" "
if [ "$r_in_unread" -gt "0" ] ; then
  r_in_unread_text="u"
fi

q_in_unread_text=" "
if [ "$q_in_unread" -gt "0" ] ; then
  q_in_unread_text="u"
fi

e_in_unread_text=" "
if [ "$e_in_unread" -gt "0" ] ; then
  e_in_unread_text="u"
fi

# spam
spam=$(mu find maildir:'/.*/.*\(spam\|junk\).*/' 2>/dev/null | wc -l)

echo " ${r_in}%{T8}${r_in_unread_text}%{T-} ${q_in}%{T8}${q_in_unread_text}%{T-} ${e_in}%{T8}${e_in_unread_text}%{T-} ${spam}"

# backup symbol •
