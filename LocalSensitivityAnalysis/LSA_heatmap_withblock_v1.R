# Load necessary libraries
library(ComplexHeatmap)
library(circlize)
library(dplyr)
library(ggplot2)  # For visualization

# Load data
#imported_data <- read.csv("/Users/hryu/Downloads/sensitivity_results_5percent_final.csv", row.names = 1, check.names = FALSE)
imported_data <- read.csv("/Users/hryu/Downloads/sensitivity_results_flattened-3.csv", row.names = 1, check.names = FALSE)


data <- imported_data[-c(7,9,10,20,24,28,50,53,70,71,72,85:88,99:100,109:110,123:125,134,136,147:150,165:197), ]

# Step 1: Filter only the columns corresponding to the positive perturbation (assuming column names include "increase")
positive_perturbation_cols <- grep("increase", colnames(data), value = TRUE)
data_pos <- data[, positive_perturbation_cols, drop = FALSE]  # Keep only these columns

# Step 2: Compute min/max before normalization
data_min <- apply(data_pos, 1, min)  # Get min value for each parameter
data_max <- apply(data_pos, 1, max)  # Get max value for each parameter
min_max_table <- data.frame(Parameter = rownames(data_pos), Min_Value = data_min, Max_Value = data_max)

# Step 3: Z-Score Normalization for Each Column
z_score_normalize <- function(x) {
  mean_x <- mean(x, na.rm = TRUE)  # Compute column mean
  sd_x <- sd(x, na.rm = TRUE)      # Compute column standard deviation
  if (sd_x != 0) {
    return((x - mean_x) / sd_x)  # Compute Z-score
  } else {
    return(rep(0, length(x)))  # If no variation, set to 0
  }
}

data_norm <- apply(data_pos, 2, z_score_normalize)  # Apply Z-score normalization column-wise

# Step 4: Identify the top 20 most sensitive parameters
sensitivity_scores <- apply(data_norm, 1, function(x) max(abs(x)))  # Sensitivity metric (max absolute deviation)
ranked_parameters <- names(sort(sensitivity_scores, decreasing = TRUE))  # Rank all parameters

#Remove unwanted parameters ("stoch_C" and "S0")
filtered_parameters <- setdiff(ranked_parameters, c("K0", "S0","Smax"))

# Select the top 20 after removing the unwanted parameters
top_23_indices <- filtered_parameters[1:23]  # Get the first 20 most sensitive ones after exclusion
data_top_23 <- data_norm[top_23_indices, , drop = FALSE]  # Subset data

math_labels <- c(
  expression(d[K]),
  expression(k[lin[alpha]]),
  expression(k[lin[F]]),
  expression(k[lin[gamma]]),
  expression(M[Phi*R*","*0]),
  expression(p[T*","*I]),
  expression(p[gamma*","*T]),
  expression(d[D]),
  expression(p[F*","*I]),
  expression(p[alpha*","*T]),
  expression(delta[I*","*K]),
  expression(C[U*","*0]),
  expression(epsilon[K*","*I]),
  expression(d[T]),
  expression(k[B[C]]),
  expression(p[L*","*M[Phi]]),
  expression(k[lin[L]]),
  expression(M[Phi[max]]),
  expression(eta[L*","*M[Phi*I]]),
  expression(p),
  expression(delta[V*","*N]),
  expression(tau[T]),
  expression(k[int[C]])
)

math_labels_column <- c(
  expression("Max Virus"),
  expression("Max dead cells"),
  expression("Min tissue"),
  expression("Max inflam. macs"),
  expression("Max T cells"),
  expression("Max NK cells"),
  expression("Inf. cells killed by NK"),
  expression("Max IL-6 cells"),
  expression("Max IFN I"),
  expression("IFN I exposure"),
  expression("Max IFN-" * gamma),
  expression("IFN-" * gamma * " exposure"),
  expression("Max TNF-" * alpha),
  expression("TNF-" * alpha * " exposure")
)


new_order <- c(3, 9, 4, 7, 2,10,16:17,19, 12,15,23, 5,18,6,14,22,1,8,13,11,20,21)
data_top_23 <- data_top_23[new_order, , drop = FALSE]
math_labels <- math_labels[new_order]

group_labels <- c("IFN I",expression("IFN-" * gamma),expression("TNF-" * alpha),  "IL-6","G-CSF", "Immune cells", "Lung cells", "Virus")
group_sizes  <- c(2, 2, 2, 3, 3, 6, 3, 2)  # must sum to 23

row_split <- factor(rep(group_labels, times = group_sizes),
                    levels = group_labels)
row_anno <- rowAnnotation(
  foo = anno_block(
    labels = group_labels,
    labels_gp = gpar(fontsize = 12, fontface = "bold"),
    gp = gpar(fill = NA, col = "black"),
    which = "row"
  ),
  width = unit(2, "cm")
)


# Step 5: Remove "(increase)" and "(increased)" from row and column names
rownames(data_top_23) <- gsub(" \\(increase[d]?\\)", "", rownames(data_top_23))  # Fix row names
colnames(data_top_23) <- gsub(" \\(increase[d]?\\)", "", colnames(data_top_23))  # Fix column names

# Step 6: Define Z-score based heatmap colors

library(circlize)

# Define improved color function with more steps
col_fun <- colorRamp2(
  seq(-3, 3, length.out = 11),
  c("#313695", "#4575B4", "#74ADD1", "#ABD9E9", "#E0F3F8", 
    "#FFFFBF",  # midpoint: no change
    "#FEE090", "#FDAE61", "#F46D43", "#D73027", "#A50026")
)


# Step 7: Generate the heatmap without row & column clustering
output_dir <- "/Users/hryu/Downloads"
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# Set output path
heatmap_file <- file.path(output_dir, "top23_heatmap_withboxv1.pdf")

# Open PDF device
pdf(file = heatmap_file, width = 8.5, height =10)

library(grid)


# Create the heatmap object
ht <- Heatmap(
  data_top_23,
  name = "Z-Score Deviation",
  col = col_fun,
  row_labels = math_labels,        # Use plotmath expressions here
  show_row_names = TRUE,
  row_names_side = "left",  # ← move row names to the left
  row_names_gp = gpar(fontsize = 16),  # ← enlarge font
  row_split = row_split,           # ← proper way to split
  left_annotation = row_anno,      # ← now works
  show_column_names = TRUE,
  column_title = "5% increase in parameter value",
  column_title_gp = gpar(fontface = "bold",fontsize = 20),  
  column_names_gp = gpar(fontsize = 16),  # ← enlarge font
  column_labels =math_labels_column,
  heatmap_legend_param = list( title = "", 
                               title = "",  # No title shown
                               at = c(-3, 0, 3),  # Set ticks manually
                               labels = c("max decrease", "no change", "max increase"),
                               labels_gp = gpar(fontsize = 16),
                               color_bar = "continuous",
                               legend_height = unit(4, "cm")
  ),
  cluster_columns = FALSE,
  cluster_rows = FALSE,
  #height = unit(15, "cm")   # ← Increase total heatmap height
)

# Explicitly draw the heatmap
draw(ht)

# Close the PDF device
dev.off()


# Step 8: Extract min/max values for the selected top 20 parameters
min_max_table_filtered <- min_max_table[min_max_table$Parameter %in% top_20_indices, ]

# Print the min/max table in the console
print(min_max_table_filtered)

# Step 9: Optional - Plot min/max values as a bar chart
ggplot(min_max_table_filtered, aes(x = reorder(Parameter, Max_Value), ymin = Min_Value, ymax = Max_Value)) +
  geom_linerange(color = "blue", size = 1) +
  geom_point(aes(y = Min_Value), color = "red", size = 3) +  # Min values in red
  geom_point(aes(y = Max_Value), color = "blue", size = 3) +  # Max values in blue
  coord_flip() +  # Flip for better readability
  labs(title = "Min & Max Values of Top 20 Sensitive Parameters",
       x = "Parameter",
       y = "Value") +
  theme_minimal()