import { describe, expect, it } from "vitest";
import { filterLocationMappings, mapLocation, mapLocationMapping } from "./locationMappings";
import { LocationMappingSchema } from "./schema";
const location = {id:"fixed-place",modernName:"北京市",longitude:116.4,latitude:39.9,coordinateSystem:"GCJ02"};
const event = {id:"event-place",locationId:location.id,kind:"event",externalId:"event-1",historicalName:"中都",location,links:[]};
describe("location mappings",()=>{
  it("keeps explicit stable IDs when a spatial record is corrected",()=>{
    expect(mapLocation({...location,longitude:116.41,modernName:"北京市西城区"}).id).toBe("fixed-place");
  });
  it("uses event dates without inventing a separate mapping interval",()=>{
    const mapping=mapLocationMapping(event);
    expect(filterLocationMappings([mapping],{fromAbs:10,toAbs:20},[{id:"event-1",atAbs:15}])).toEqual([mapping]);
    expect(filterLocationMappings([mapping],{fromAbs:16,toAbs:20},[{id:"event-1",atAbs:15}])).toEqual([]);
    expect(filterLocationMappings([mapping],{fromAbs:10,toAbs:20})).toEqual([]);
  });
  it("rejects mismatched spatial references, explanatory names and event capital dates",()=>{
    for(const patch of [{locationId:"missing"},{historicalName:"中都（今北京）"},{historicalName:"会战代表点"},{startAbs:1}]) {
      expect(LocationMappingSchema.safeParse({...event,...patch}).success).toBe(false);
    }
  });
});
