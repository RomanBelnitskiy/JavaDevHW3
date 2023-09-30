CREATE TYPE LEVEL AS ENUM ('Trainee', 'Junior', 'Middle', 'Senior');
CREATE TABLE IF NOT EXISTS worker (
  ID BIGINT NOT NULL,
  NAME VARCHAR(1000) NOT NULL,
  BIRTHDAY DATE,
  LEVEL LEVEL NOT NULL,
  SALARY INTEGER,
  CONSTRAINT WORKER_PK PRIMARY KEY(ID), 
  CONSTRAINT WORKER_NAME_MIN_LENGTH CHECK(CHAR_LENGTH(NAME)>=2),
  CONSTRAINT WORKER_BIRTHDAY_MIN_DATE CHECK(BIRTHDAY>'1900-01-01'),
  CONSTRAINT WORKER_SALARY_MIN CHECK(SALARY>=100),
  CONSTRAINT WORKER_SALARY_MAX CHECK(SALARY<=100000)
);

CREATE TABLE IF NOT EXISTS client (
  ID BIGINT NOT NULL,
  NAME VARCHAR(1000) NOT NULL,
  CONSTRAINT CLIENT_PK PRIMARY KEY(ID), 
  CONSTRAINT CLIENT_NAME_MIN_LENGTH CHECK(CHAR_LENGTH(NAME)>=2)
);

CREATE TABLE IF NOT EXISTS project (
  ID BIGINT NOT NULL,
  CLIENT_ID BIGINT NOT NULL,
  START_DATE DATE NOT NULL DEFAULT CURRENT_DATE,
  FINISH_DATE DATE,
  CONSTRAINT PROJECT_PK PRIMARY KEY(ID), 
  CONSTRAINT PROJECT_CLIENT_FK FOREIGN KEY (CLIENT_ID) REFERENCES client(ID),
  CONSTRAINT PROJECT_START_FINISH_DATE CHECK(START_DATE<FINISH_DATE)
);

CREATE TABLE IF NOT EXISTS project_worker (
  PROJECT_ID BIGINT NOT NULL,
  WORKER_ID BIGINT NOT NULL, 
  CONSTRAINT PROJECT_WORKER_PROJECT_FK FOREIGN KEY (PROJECT_ID) REFERENCES project(ID),
  CONSTRAINT PROJECT_WORKER_WORKER_FK FOREIGN KEY (WORKER_ID) REFERENCES worker(ID),
  CONSTRAINT PROJECT_WORKER_PK PRIMARY KEY(PROJECT_ID, WORKER_ID)
);
