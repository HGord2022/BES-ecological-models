
library(bbnet) # loads in BBNet package - assuming it is installed

setwd("~/github_repos/BES-ecological-models")

rm(list = ls(all = TRUE))  ### removes any stored variables

int.matrix<-read.csv("interaction.csv", header=T)  # read in files - this should be n x n+1 dataframe

Scenario1<-read.csv('treatment.csv', header=T) # read in files - should be an n x 2 matrix 

#### Running a prediction

bbn.predict(bbn.model=int.matrix, priors1 = Scenario1, figure=2)
# look at paper or R markdown for other arguments for this function 
# or type ?bbn.predict into the R window

ggsave("./effects1.png")

Scenario2<-read.csv('treatment2.csv', header=T) # can run up to 6 scenarios at once

bbn.predict(bbn.model=int.matrix, priors1 = Scenario1, priors2 = Scenario2, figure=2, boot_max = 100, font.size = 6)
## this will run two scenarios at once. The values will also have confidence intervals from bootstraps (100 isn't enough really, but it can take a lonmg time to do more
## font size in the figure can also be altered
ggsave("./effects_2scenario.png")

########### Checking edge sensitivity 

int.matrix[,1] ## gives exact names of variables to use

bbn.sensitivity(bbn.model = int.matrix, boot_max = 100, 'Invertebrates', 'Resiliance')
#### Node1 is the name of a key output node - spelt and capitalised identically to the priors/scenario value. 
# One or multiple nodes can be used - suggested no more than 3 
# boot_max=100 is realtively quick, but not accurate. ideally run with 10000 (can be good to let run overnight, as this will be slow)

ggsave("./sensitivity.png")

############ Visualizing information flow

bbn.timeseries(bbn.model = int.matrix, priors1 = Scenario1, timesteps = 5, disturbance = 2)
### look at each node by timestep - not values do not correspond to the 'predict' function

ggsave("./timeseries.png")

bbn.visualise(bbn.model = int.matrix, priors1 = Scenario1, timesteps = 5, disturbance = 2, threshold=0.05, font.size=0.7, arrow.size=4)
### look at all nodes and interactions - dark = maximum increase, light = maximum decrease at this timestep

########### Visualising the full network

#### note, this needs a slightly different input file to the interaction matrix

vis.matrix <-read.csv("vis_interaction.csv", header=T)  # read in file

head(vis.matrix) ## shows the strucure of the file

bbn.network.diagram(bbn.network = vis.matrix, font.size = 0.7, arrow.size = 4, arrange = layout_on_sphere)
bbn.network.diagram(bbn.network = vis.matrix, font.size = 0.7, arrow.size = 2, arrange = layout_on_grid)
bbn.network.diagram(bbn.network = vis.matrix, font.size = 0.7, arrow.size = 2, arrange = layout.random)
bbn.network.diagram(bbn.network = vis.matrix, font.size = 0.7, arrow.size = 3, arrange = layout.circle)
## series of different layouts for the network diagram 








