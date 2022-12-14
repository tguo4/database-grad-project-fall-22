-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.appearance
(
    game_id integer NOT NULL,
    player_id integer NOT NULL,
    "position" character varying(20) COLLATE pg_catalog."default",
    assists integer,
    num_shots integer,
    goals integer,
    yellow_cards integer,
    red_cards integer,
    CONSTRAINT appearance_pkeys PRIMARY KEY (game_id, player_id)
);

CREATE TABLE IF NOT EXISTS public.game
(
    game_id integer NOT NULL,
    season_id integer,
    venue_id integer,
    game_date date,
    home_goals integer,
    away_goals integer,
    CONSTRAINT game_pkeys PRIMARY KEY (game_id)
);

CREATE TABLE IF NOT EXISTS public.gameteam
(
    game_id integer NOT NULL,
    home_team_id integer,
    away_team_id integer,
    CONSTRAINT game_team_id PRIMARY KEY (game_id)
        INCLUDE(home_team_id, away_team_id)
);

CREATE TABLE IF NOT EXISTS public.league
(
    league_id integer NOT NULL,
    league_name character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT league_pkey PRIMARY KEY (league_id)
);

CREATE TABLE IF NOT EXISTS public.manager
(
    manager_id integer NOT NULL,
    manager_name character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT manager_pkey PRIMARY KEY (manager_id)
);

CREATE TABLE IF NOT EXISTS public.managerteam
(
    contract_id integer NOT NULL,
    manager_id integer,
    team_id integer,
    start_date date,
    end_date date,
    CONSTRAINT contract_id PRIMARY KEY (contract_id)
);

CREATE TABLE IF NOT EXISTS public.player
(
    player_id integer NOT NULL,
    player_name character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT player_pkey PRIMARY KEY (player_id)
);

CREATE TABLE IF NOT EXISTS public.season
(
    season_id integer NOT NULL,
    league_id integer,
    champion_id integer,
    year integer,
    start_date date,
    end_date date,
    CONSTRAINT season_pkeys PRIMARY KEY (season_id)
);

CREATE TABLE IF NOT EXISTS public.shot
(
    shot_id integer NOT NULL,
    game_id integer,
    shooter_id integer,
    assist_id integer,
    situation character varying(50) COLLATE pg_catalog."default",
    shot_type character varying(50) COLLATE pg_catalog."default",
    shot_result character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT shot_pkeys PRIMARY KEY (shot_id)
);

CREATE TABLE IF NOT EXISTS public.team
(
    team_id integer NOT NULL,
    venue_id integer,
    team_name character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT team_pkeys PRIMARY KEY (team_id)
);

CREATE TABLE IF NOT EXISTS public.venue
(
    venue_id integer NOT NULL,
    venue_name character varying(100) COLLATE pg_catalog."default",
    capacity integer,
    address character varying(200) COLLATE pg_catalog."default",
    city character varying(50) COLLATE pg_catalog."default",
    country character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT venue_pkey PRIMARY KEY (venue_id)
);

ALTER TABLE IF EXISTS public.appearance
    ADD CONSTRAINT game_id FOREIGN KEY (game_id)
    REFERENCES public.game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.appearance
    ADD CONSTRAINT player_id FOREIGN KEY (player_id)
    REFERENCES public.player (player_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.game
    ADD CONSTRAINT season_id FOREIGN KEY (season_id)
    REFERENCES public.season (season_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.game
    ADD CONSTRAINT venue_id FOREIGN KEY (venue_id)
    REFERENCES public.venue (venue_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.gameteam
    ADD CONSTRAINT away_team_id FOREIGN KEY (away_team_id)
    REFERENCES public.team (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.gameteam
    ADD CONSTRAINT game_id FOREIGN KEY (game_id)
    REFERENCES public.game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.gameteam
    ADD CONSTRAINT home_team_id FOREIGN KEY (home_team_id)
    REFERENCES public.team (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.managerteam
    ADD CONSTRAINT manager_id FOREIGN KEY (manager_id)
    REFERENCES public.manager (manager_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.managerteam
    ADD CONSTRAINT team_id FOREIGN KEY (team_id)
    REFERENCES public.team (team_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.season
    ADD CONSTRAINT champion_id FOREIGN KEY (champion_id)
    REFERENCES public.player (player_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.season
    ADD CONSTRAINT league_id FOREIGN KEY (league_id)
    REFERENCES public.league (league_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.shot
    ADD CONSTRAINT assist_id FOREIGN KEY (assist_id)
    REFERENCES public.player (player_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.shot
    ADD CONSTRAINT game_id FOREIGN KEY (game_id)
    REFERENCES public.game (game_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.shot
    ADD CONSTRAINT shooter_id FOREIGN KEY (shooter_id)
    REFERENCES public.player (player_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.team
    ADD CONSTRAINT venue_id FOREIGN KEY (venue_id)
    REFERENCES public.venue (venue_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;