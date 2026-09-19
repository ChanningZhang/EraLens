/**
 * Calendar-adjacent reign seams must share uncertainty on both sides.
 * Anchored reigns (no interpolated flags) keep their anchor-facing edge certain;
 * otherwise propagate interpolated to the certain neighbor.
 */

function isUncertain(value) {
  return value === "interpolated" || value === "approximate";
}

function isAnchoredReign(reign) {
  return !isUncertain(reign.startDateConfidence) && !isUncertain(reign.endDateConfidence);
}

function isCalendarSeamPair(left, right, active) {
  const leftTrack = left.claimTrack ?? null;
  const rightTrack = right.claimTrack ?? null;
  if (leftTrack != null && rightTrack != null && leftTrack !== rightTrack) return false;
  const leftEndExclusive = left.endAbs + 1;
  if (right.startAbs !== leftEndExclusive) return false;
  if (left.dynastyId === right.dynastyId) return true;

  const leftHasDynastySuccessor = active.some(
    (reign) =>
      reign.id !== left.id &&
      reign.dynastyId === left.dynastyId &&
      reign.startAbs === right.startAbs,
  );
  if (leftHasDynastySuccessor) return false;

  const rightHasDynastyPredecessor = active.some(
    (reign) =>
      reign.id !== right.id &&
      reign.dynastyId === right.dynastyId &&
      reign.endAbs + 1 === right.startAbs,
  );
  if (rightHasDynastyPredecessor) return false;

  return true;
}

export function alignReignSeamConfidences(reigns) {
  const active = reigns.filter((reign) => reign.personId !== "system-missing-ruler");

  for (const left of active) {
    const successors = active.filter(
      (right) => right.id !== left.id && isCalendarSeamPair(left, right, active),
    );

    for (const right of successors) {
      const leftUncertain = isUncertain(left.endDateConfidence);
      const rightUncertain = isUncertain(right.startDateConfidence);
      if (leftUncertain === rightUncertain) continue;

      const leftAnchored = isAnchoredReign(left);
      const rightAnchored = isAnchoredReign(right);

      if (rightAnchored && leftUncertain) {
        left.endDateConfidence = null;
      } else if (leftAnchored && rightUncertain) {
        right.startDateConfidence = null;
      } else if (rightUncertain) {
        left.endDateConfidence = "interpolated";
      } else {
        right.startDateConfidence = "interpolated";
      }
    }
  }

  return reigns;
}
