import type { CapitalLocation, LocationMapping, LocationKind } from "../src/schema";
export function locationFixture(c: CapitalLocation,kind:LocationKind="dynasty",externalId=c.dynastyId): LocationMapping {
 return {id:c.id,kind,externalId,locationId:c.id,location:{id:c.id,modernName:c.modernName,longitude:c.longitude,latitude:c.latitude,coordinateSystem:c.coordinateSystem},historicalName:c.historicalName,start:c.start,end:c.end,startAbs:c.startAbs,endAbs:c.endAbs,startConfidence:c.startConfidence,endConfidence:c.endConfidence,role:c.role,note:c.note,links:c.links};
}
