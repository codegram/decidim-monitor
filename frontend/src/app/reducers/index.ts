import { ActionReducerMap, ActionReducer, MetaReducer } from "@ngrx/store";
import { environment } from "../../environments/environment";
import { RouterStateUrl } from "../shared/utils";
import * as fromRouter from "@ngrx/router-store";

import { apolloReducer, CacheState } from "apollo-angular-cache-ngrx";

/**
 * storeFreeze prevents state from being mutated. When mutation occurs, an
 * exception will be thrown. This is useful during development mode to
 * ensure that none of the reducers accidentally mutates the state.
 */
import { storeFreeze } from "ngrx-store-freeze";

/**
 * As mentioned, we treat each reducer like a table in a database. This means
 * our top level state interface is just a map of keys to inner state types.
 */
export interface State {
  apollo: CacheState;
  router: fromRouter.RouterReducerState<RouterStateUrl>;
}

/**
 * Our state is composed of a map of action reducer functions.
 * These reducer functions are called with each dispatched action
 * and the current or initial state and return a new immutable state.
 */
export const reducers: ActionReducerMap<State> = {
  apollo: apolloReducer,
  router: fromRouter.routerReducer
};

export const metaReducers: MetaReducer<State>[] = !environment.production
  ? [storeFreeze]
  : [];
