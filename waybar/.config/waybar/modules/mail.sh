#!/bin/bash

# inbox
r_in=$(mu find maildir:/r/INBOX 2>/dev/null | wc -l)
q_in=$(mu find maildir:/q/INBOX 2>/dev/null | wc -l)
e_in=$(mu find maildir:/e/INBOX 2>/dev/null | wc -l)

# inbox unread
r_in_unread=$(mu find maildir:/r/INBOX flag:unread 2>/dev/null | wc -l)
q_in_unread=$(mu find maildir:/q/INBOX flag:unread 2>/dev/null | wc -l)
e_in_unread=$(mu find maildir:/e/INBOX flag:unread 2>/dev/null | wc -l)

if [ "$r_in_unread" == "0" ] ; then
  r_in_unread_text="<span font='DejaVuSansMono Nerd Font 12' font_scale='superscript' rise='7000'> </span>"
else
  r_in_unread_text="<span font='DejaVuSansMono Nerd Font 12' font_scale='superscript' rise='7000'></span>"
fi

if [ "$q_in_unread" == "0" ] ; then
  q_in_unread_text="<span font='DejaVuSansMono Nerd Font 12' font_scale='superscript' rise='7000'> </span>"
else
  q_in_unread_text="<span font='DejaVuSansMono Nerd Font 12' font_scale='superscript' rise='7000'></span>"
fi

if [ "$e_in_unread" == "0" ] ; then
  e_in_unread_text="<span font='DejaVuSansMono Nerd Font 12' font_scale='superscript' rise='7000'> </span>"
else
  e_in_unread_text="<span font='DejaVuSansMono Nerd Font 12' font_scale='superscript' rise='7000'></span>"
fi

# spam
spam=$(mu find maildir:/r/Spam/ OR maildir:/q/INBOX.spambucket OR maildir:'/e/Junk\ E-Mail' 2>/dev/null | wc -l)

echo "${r_in}${r_in_unread_text} ${q_in}${q_in_unread_text} ${e_in}${e_in_unread_text} ${spam}"

# backup symbol •
