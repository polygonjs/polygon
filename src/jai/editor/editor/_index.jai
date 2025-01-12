#load "Editor.jai";
#load "EditorDelete.jai";
#load "EditorEvent.jai";
#load "EditorEventCommands.jai";
#load "EditorNodePosition.jai";
#load "EditorNodeSelection.jai";
#load "EditorNodesScene.jai";
#load "EditorOnTick.jai";
#load "EditorRender.jai";
#load "EditorResize.jai";

#load "history/_index.jai";


#if WASM { #load "targets/EditorWasm.jai"; }
else { #load "targets/EditorNative.jai"; }