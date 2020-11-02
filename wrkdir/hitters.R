FLAGS <- flags(
        flag_numeric("nodes", 50),
        flag_numeric("batch_size", 100),
        flag_string("activation", "relu"),
        flag_numeric("learning_rate", 0.01),
        flag_numeric("epochs", 30)
)

model <- keras_model_sequential()
model %>%
        layer_dense( units = FLAGS$nodes, activation = FLAGS$activation, input_shape = dim(hitters_scale_train)[2]) %>%
        layer_dense( units = FLAGS$nodes, activation = FLAGS$activation) %>%
        layer_dense( units = FLAGS$nodes, activation = FLAGS$activation) %>%
        layer_dense( units = 1)

set.seed(1)
model %>% compile (
        loss = 'mse',
        optimizer = optimizer_sgd(lr=FLAGS$learning_rate))

model %>% fit (x = as.matrix(hitters_scale_train), y = hitters_train_labels, epochs = FLAGS$epochs, batch_size = FLAGS$batch_size, validation_data = list(as.matrix(hitters_scale_val), hitters_val_labels))