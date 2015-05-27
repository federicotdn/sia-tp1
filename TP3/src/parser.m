% Configuration Parser

source('crossover.m');
source('selection.m');

function config = parse_config()
	fid = fopen('config.txt', 'r');
	while !feof(fid)
  	text_line = fgetl(fid);

    if length(text_line) == 0 || text_line(1) == '%'
      continue;
    end

  	split = strsplit(text_line, '=');
  	key = split{1};
  	value = split{2};

  	switch key
  		case 'arch'
  			config.arch = parse_to_array(strsplit(value, ','));
  		case 'rand_limit'
  			config.rand_limit = str2double(value);
      case 'population_size'
        config.population_size = str2double(value);
      case 'replacement_method'
        config.replacement_method = str2double(value);
      case 'max_generations'
        config.max_generations = str2double(value);
      case 'mutation_prob'
        config.mutation_prob = str2double(value);
      case 'mutation_range'
        config.mutation_range = str2double(value);
      case 'range'
        aux = parse_to_array(strsplit(value, ','));
        config.range = (aux(1):aux(2):aux(3));
  	  case 'selection'
        config.selection = value;
      case 'selection_k'
        config.selection_k = str2double(value);
      case 'tournament_m'
        config.tournament_m = str2double(value);
      case 'replacement_selection'
        config.replacement_selection = value;
      case 'replacement_tournament_m'
        config.replacement_tournament_m = str2double(value);
      case 'cross_function'
        config.cross_function = parse_cross_function(value);
    end
	end

  fclose(fid);
end

function array = parse_to_array(cell_string)
	for i = cell_string
		array(end + 1) = str2double(i{1});
	end
end

function fn = parse_cross_function(string)
  switch string
    case 'one_point'
      fn = @one_point_cross;
    case 'two_point'
      fn = @two_point_cross;
    case 'anular_point'
      fn = @anular_cross;
    case 'uniform_point'
      fn = @uniform_cross;
  end
end

function fn = parse_selection_function(string)
  switch string
    case 'elite'
      fn = @elite;
    case 'mixed'
      fn = @mixed;
    case 'roulette'
      fn = @roulette;
    case 'deterministic_tournament'
      fn = @deterministic_tournament
    case 'probabilistic_tournament'
      fn = @probabilistic_tournament
    case 'universal'
      fn = @universal
  end
end