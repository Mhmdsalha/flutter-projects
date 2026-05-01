abstract class news_states {}

class initialstate extends news_states {}

class BNBstate extends news_states {}

class get_business_data_state extends news_states {}

class get_science_data_state extends news_states {}

class get_sports_data_state extends news_states {}

class get_search_data_state extends news_states {}

class error_data_state extends news_states {
  final String error;
  error_data_state(this.error);
}

class business_loading_state extends news_states {}

class sports_loading_state extends news_states {}

class science_loading_state extends news_states {}

class search_loading_state extends news_states {}

class theme_state extends news_states {}
class language_state extends news_states {}
