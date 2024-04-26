select s._id, s.name, s.created_at, s.deleted_at
from dictionary.`schemas` as s
order by s._id;