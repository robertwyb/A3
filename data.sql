INSERT INTO Student (sid, first_name, last_name) VALUES 
(0998801234, 'lena', 'Headey'),
(0010784522, 'Peter', 'Dinklage'),
(0997733991, 'Emilia', 'Clarke'),
(5555555555, 'Kit', 'Harrington'),
(1111111111, 'Sophie', 'Turner'),
(2222222222, 'Maisie', 'Williams');

INSERT INTO Class (cid, rid, grade) VALUES 
(1, 120, 8),
(2, 366, 5);

INSERT INTO Room (rid, teacher) VALUES 
(120, 'Mr higgins'),
(366, 'Miss Nyers');

INSERT INTO Questions (qid, type, qtext) VALUES 
(782, 'Multiple-choice', 'What do you promise when you take the oath of citizenship?'),
(566, 'True-False', 'The Prime Minister, Justin Trudeau, is Canada''s Head of State.'),
(601, 'Numeric', 'During the "Quiet Revolution," Quebec experienced rapid change. In what
decade did this occur? (Enter the year that began the decade, e.g., 1840.)'),
(625, 'Multiple-choice', 'What is the Underground Railroad?'),
(790, 'Multiple-choice', 'During the War of 1812 the Americans burned down the Parliament Buildings in
York (now Toronto). What did the British and Canadians do in return?');

INSERT INTO McT (qid, mc_ans) VALUES 
(782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II'),
(625, 'A network used by slaves who escaped the United States into Canada'),
(790, 'They burned down the White House in Washington D.C.');

INSERT INTO McF (qid, options, hint) VALUES 
(782, 'To pledge your allegiance to the flag and fulfill the duties of a Canadian', 'Think regally'),
(625, 'The first railway to cross Canada', 'The Underground Railroad was generally south to north, 
      not east-west.'),
(625, 'The CPR''s secret railway line', 'The Underground Railroad was secret, but it had nothing to do 
      with trains.'),
(625, 'The TTC subway system', 'The TTC is relatively recent; the Underground Railroad was 
      in operation over 100 years ago.'),
(790, 'They attacked American merchant ships' , NULL);
      

INSERT INTO NumT (qid, num_ans) VALUES 
(601, 1960);

INSERT INTO NumF (qid, lb, ub, hint) VALUES 
(601, 1800, 1900, 'The Quiet Revolution happened during the 20th 
   Century.'),
(601, 2000, 2010, 'The Quiet Revolution happened some time ago.'),
(601, 2020, 3000, 'The Quiet Revolution has already happened!');

INSERT INTO TfT (qid, tf_ans) VALUES 
(566, 'False');

INSERT INTO Enrol (sid, cid) VALUES
(0998801234, 1),
(0010784522, 1),
(0997733991, 1),
(5555555555, 1),
(1111111111, 1),
(2222222222, 2);

INSERT INTO Quiz (qzid, title, dtime, ddate, cid, hintset) VALUES 
('Pr1-220310', 'Citizenship Test Practise Questions', '1:30 pm', 'Oct 1, 2017', 1, 'True');

INSERT INTO Qz_enr (qzid, qid, weight) VALUES 
('Pr1-220310', 601, 2),
('Pr1-220310', 566, 1),
('Pr1-220310', 790, 3),
('Pr1-220310', 625, 2);

INSERT INTO Mc_record (sid, qzid, qid, record) VALUES 
(0998801234, 'Pr1-220310', 625, 'A network used by slaves who escaped the United States into Canada'),
(0998801234, 'Pr1-220310', 790, 'They expanded their defence system, including Fort York'),
(0010784522, 'Pr1-220310', 625, 'A network used by slaves who escaped the United States into Canada'),
(0010784522, 'Pr1-220310', 790, 'They burned down the White House in Washington D.C.'),
(0997733991, 'Pr1-220310', 625, 'The CPR''s secret railway line'),
(0997733991, 'Pr1-220310', 790, 'They burned down the White House in Washington D.C.'),
(5555555555, 'Pr1-220310', 790, 'They captured Niagara Falls'),
(5555555555, 'Pr1-220310', 625, 'no answer'),
(1111111111, 'Pr1-220310', 625, 'no answer'),
(1111111111, 'Pr1-220310', 790, 'no answer');


INSERT INTO Num_record (sid, qzid, qid, record) VALUES 
(0998801234, 'Pr1-220310', 601, 1950),
(0010784522, 'Pr1-220310', 601, 1960),
(0997733991, 'Pr1-220310', 601, 1960);


INSERT INTO Tf_record (sid, qzid, qid, record) VALUES 
(0998801234, 'Pr1-220310', 566, 'False'),
(0010784522, 'Pr1-220310', 566, 'False'),
(0997733991, 'Pr1-220310', 566, 'True'),
(5555555555, 'Pr1-220310', 566, 'False');