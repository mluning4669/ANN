FLAGS <- flags(
        flag_numeric("nodes", 50),
        flag_numeric("batch_size", 100),
        flag_string("activation", "relu"),
        flag_numeric("learning_rate", 0.01),
        flag_numeric("epochs", 30)
)

model <- keras_model_sequential()
model %>%
        layer_dense( units = FLAGS$nodes, activation = FLAGS$activation, input_shape = 10000) %>%
        layer_dense( units = FLAGS$nodes, activation = FLAGS$activation) %>%
        layer_dense( units = FLAGS$nodes, activation = FLAGS$activation) %>%
        layer_dense(units = 46, activation = 'softmax')

set.seed(123)
model %>% compile (
        loss = 'sparse_categorical_crossentropy',
        optimizer = optimizer_adam(lr=FLAGS$learning_rate),
        metrics = 'accuracy')

model %>% fit (x = reuters_train, y = reuters_train_labels, epochs = FLAGS$epochs, batch_size = FLAGS$batch_size, validation_data = list(reuters_validation_x, validation_labels))