
<h1 align="center">TD-Gammon</h1> <br>
<p align="center">
   <img alt="Backgammon" title="Backgammon" src="logo.png" width="350">
</p>

---
# Table of Contents
- [Build](#build)
    - [Run in production mode](#run-in-production-mode)
    - [Run in developing mode](#run-in-developing-mode)
- [Usage](#usage)
    - [Train TD-Network](#train-td-network)
    - [Evaluate Agent(s)](#evaluate-agents)
    - [Web Interface](#web-interface)
    - [Plot Wins](#plot-wins)

---
## Build

Run `docker build -t td-gammon .` for building the image.

### Run in production mode

Run `docker run -ti --name td-gammon -p 8080:80 td-gammon` for running in production mode.

### Run in developing mode

Run `docker run -ti --name td-gammon -p 8080:80 -v $PWD/td_gammon:/app/td_gammon td-gammon` for running in developing mode.

---
## Usage
Run `python /path/to/main.py --help` for a list of parameters.

### Train TD-Network
To train a neural network with a single layer with `40` hidden units, for `100000` games/episodes and save the model every `10000`, run the following command:
```
(tdgammon) $ python /path/to/main.py train --save_path ./saved_models/exp1 --save_step 10000 --episodes 100000 --name exp1 --type nn --lr 0.1 --hidden_units 40
```
Run `python /path/to/main.py train --help` for a list of parameters available for training.

---
### Evaluate Agent(s)
To evaluate an already trained models, you have to options: evaluate models to play against each other or evaluate one model against `gnubg`.
Run `python /path/to/main.py evaluate --help` for a list of parameters available for evaluation.

#### Agent vs Agent
To evaluate two model to play against each other you have to specify the path where the models are saved with the corresponding number of hidden units.
```
(tdgammon) $ python /path/to/main.py evaluate --episodes 50 --hidden_units_agent0 40 --hidden_units_agent1 40 --type nn --model_agent0 path/to/saved_models/agent0.tar --model_agent1 path/to/saved_models/agent1.tar
```

#### Agent vs gnubg
To evaluate one model to play against `gnubg`, first you have to run `gnubg` with the script `bridge` as input.
On Ubuntu (or where `gnubg` is installed)
```
gnubg -t -p /path/to/bridge.py
```
Then run (to play vs `gnubg` at intermediate level for 100 games):
```
(tdgammon) $ python /path/to/main.py evaluate --episodes 50 --hidden_units_agent0 40 --type nn --model_agent0 path/to/saved_models/agent0.tar vs_gnubg --difficulty beginner --host GNUBG_HOST --port GNUBG_PORT
```
The hidden units (`--hidden_units_agent0`) of the model must be same of the loaded model (`--model_agent0`).

---
### Web Interface
You can play against a trained agent via a web gui:
```
(tdgammon) $ python /path/to/main.py gui --host localhost --port 8002 --model path/to/saved_models/agent0.tar --hidden_units 40 --type nn
```
Then navigate to `http://localhost:8002` in your browser:
<p align="center">
   <img alt="Web Interface" title="Web Interface" src="gui_example.png">
</p>

Run `python /path/to/main.py gui --help` for a list of parameters available about the web gui.

---
### Plot Wins
Instead of evaluating the agent during training (it can require some time especially if you evaluate against `gnubg` - difficulty `world_class`), you can load all the saved models in a folder, and evaluate each model (saved at different time during training) against one or more opponents.
The models in the directory should be of the same type (i.e the structure of the network should be the same for all the models in the same folder).

To plot the wins against `gnubg`, run on Ubuntu (or where `gnubg` is installed):
```
gnubg -t -p /path/to/bridge.py
```
In the example below the trained model is going to be evaluated against `gnubg` on two different difficulties levels - `beginner` and `advanced`:`
```
(tdgammon) $ python /path/to/main.py plot --save_path /path/to/saved_models/myexp --hidden_units 40 --episodes 10 --opponent random,gnubg --dst /path/to/experiments --type nn --difficulty beginner,advanced --host GNUBG_HOST --port GNUBG_PORT
```
To visualize the plots:
```
(tdgammon) $ tensorboard --logdir=runs/path/to/experiment/ --host localhost --port 8001
```
Run `python /path/to/main.py plot --help` for a list of parameters available about plotting.
