from sklearn.ensemble import VotingClassifier
from numpy.ndarray import flatten


def k-modes (E, isRelabelled=True, seed=1):
	mv = VotingClassifier(E)
	flat_E = E.flatten
