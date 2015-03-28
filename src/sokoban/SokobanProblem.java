package sokoban;

import java.util.LinkedList;
import java.util.List;

import sokoban.SokobanRule.Direction;
import sokoban.heuristics.SokobanHeuristic;

import gps.api.GPSProblem;
import gps.api.GPSRule;
import gps.api.GPSState;

public class SokobanProblem implements GPSProblem {

	private Board initBoard;
	private SokobanHeuristic hFunction;
	
	public SokobanProblem(Board board, SokobanHeuristic hFunction) {
		initBoard = board;
		this.hFunction = hFunction;
	}
	
	@Override
	public GPSState getInitState() {
		return new SokobanState(initBoard);
	}

	@Override
	public boolean isGoalState(GPSState state) {
		/*
		 * Downcast para no tener que cambiar la interfaz de la catedra.
		 */
		SokobanState st = (SokobanState) state;
		return st.getBoard().isCompleted();
	}

	@Override
	public List<GPSRule> getRules() {
		LinkedList<GPSRule> list = new LinkedList<GPSRule>();
		for (Direction dir : Direction.values()) {
			list.add(new SokobanRule(dir));
		}
		return list;
	}

	@Override
	public Integer getHValue(GPSState state) {
		/*
		 * Downcast para no tener que cambiar la interfaz de la catedra.
		 */
		SokobanState st = (SokobanState) state;
		return hFunction.getHValue(st.getBoard());
	}

}
