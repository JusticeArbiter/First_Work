create view vview as  select pparent.pid, txt, descrip from  pparent left join cchild using (pid);
