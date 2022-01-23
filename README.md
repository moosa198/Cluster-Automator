# Cluster-Automator
Automated DBSCAN outputs in R

The cluster_automator() function uses point data to simplify the process of: 
first, applying a DBSCAN algorithm to determine spatial clustering; 
second, being able to visualise the spatial clustering with a plotted output; 
and third, determining the optimal distance bands (epsilons) for the DBSCAN, by providing the option to output a K-Nearest Neighbour (KNN) Distance plot (See Appendix). 

Furthermore, the user is also left with a ‘db’ object with the raw DBSCAN output, for any potential use beyond the function plot.
The function takes three mandatory arguments: the data, and the indices for the two columns containing the point coordinates, in longitude and latitude. 

Also, the function provides eight optional arguments, to expand the range of analysis and plot style that is possible with the function (see table).
Applying a clustering algorithm, such as DBSCAN, often requires the completion of multiple separate steps in order to successfully output a plot of point patterns in spatial data - sometimes repeatedly, to adjust different values in the data, the DBSCAN, or the plot itself. 
Moreover, it also often requires a fuller understanding of the specifics of projection systems and optimal epsilons, which may act as a barrier to use. 
Thus, the cluster_automator() function both provides ease of use, by combining these separate steps into a single function, correcting for common errors (see flowchart), while also providing the user with a breadth of further expansion options, to tweak specific parameters at each step in the analysis. 
Moreover, if the user is not satisfied with the base plot output, they are provided a raw DBSCAN object with which to conduct further analysis.
