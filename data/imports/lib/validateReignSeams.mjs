/**
 * Calendar-adjacent reign seams must mark uncertainty on both sides or neither.
 * Mirrors packages/shared/src/reignBoundaries.ts validateReignDateConfidenceSeams.
 */

function isUncertain(value) {
  return value === "interpolated" || value === "approximate";
}

function reignEndExclusive(reign) {
  const endAbs = reign.endAbs ?? reign.end?.abs;
  return endAbs + 1;
}

function claimTrackPairOk(left, right) {
  const leftTrack = left.claimTrack ?? null;
  const rightTrack = right.claimTrack ?? null;
  if (leftTrack == null && rightTrack == null) return true;
  return leftTrack === rightTrack;
}

function isCalendarSeamPair(left, right, active) {
  if (!claimTrackPairOk(left, right)) return false;
  const leftEndExclusive = reignEndExclusive(left);
  const rightStart = right.startAbs ?? right.start?.abs;
  if (rightStart !== leftEndExclusive) return false;
  if (left.dynastyId === right.dynastyId) return true;

  const leftHasDynastySuccessor = active.some(
    (reign) =>
      reign.id !== left.id &&
      reign.dynastyId === left.dynastyId &&
      (reign.startAbs ?? reign.start?.abs) === rightStart,
  );
  if (leftHasDynastySuccessor) return false;

  const rightHasDynastyPredecessor = active.some(
    (reign) =>
      reign.id !== right.id &&
      reign.dynastyId === right.dynastyId &&
      reignEndExclusive(reign) === rightStart,
  );
  if (rightHasDynastyPredecessor) return false;

  return true;
}

export function validateReignDateConfidenceSeams(reigns) {
  const errors = [];
  const active = reigns.filter((reign) => reign.personId !== "system-missing-ruler");

  for (const left of active) {
    const successors = active.filter(
      (right) => right.id !== left.id && isCalendarSeamPair(left, right, active),
    );
    for (const right of successors) {
      const leftUncertain = isUncertain(left.endDateConfidence);
      const rightUncertain = isUncertain(right.startDateConfidence);
      if (leftUncertain === rightUncertain) continue;
      errors.push(
        `${left.id} end (${left.endDateConfidence ?? "certain"}) / ${right.id} start (${right.startDateConfidence ?? "certain"}) mismatch`,
      );
    }
  }

  return errors;
}
