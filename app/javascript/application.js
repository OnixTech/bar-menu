// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { createConsumer } from "@rails/actioncable";

const consumer = createConsumer();

export default consumer;
