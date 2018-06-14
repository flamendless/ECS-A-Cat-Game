local record = ECS.Component(function(e)
	e.isRecording = false
	e.isReplaying = false
	e.data = {}
end)

return record
