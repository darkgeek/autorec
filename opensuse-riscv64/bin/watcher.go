package main

import (
    "log/syslog"
    "log"
    "os"
    "github.com/fsnotify/fsnotify"
)

var logger *log.Logger = getSyslog()

type Watcher interface {
    start(string)
}

type FsnotifyWatcher struct {
}

func (f FsnotifyWatcher) start(filePath string) {
    // Create new watcher.
    watcher, err := fsnotify.NewWatcher()
    if err != nil {
        logger.Fatal(err)
    }
    defer watcher.Close()

    // Start listening for events.
    go func() {
        for {
            select {
            case event, ok := <-watcher.Events:
                if !ok {
                    return
                }
                logger.Println("[filewatcher] event:", event)
                if event.Has(fsnotify.Write) {
                    logger.Println("[filewatcher] modified file:", event.Name)
                }
                fileInfo, err := os.Stat(filePath)
                if (err != nil) {
                    logger.Println("[filewatcher] Error:", err)
                }
                if (fileInfo.Size() != 0) {
                    logger.Printf("[filewatcher] file %s has content now.\n", filePath)
                    os.Exit(0)
                }
            case err, ok := <-watcher.Errors:
                if !ok {
                    return
                }
                logger.Println("[filewatcher] error:", err)
            }
        }
    }()

    // Add a path.
    err = watcher.Add(filePath)
    if err != nil {
        logger.Fatal(err)
    }

    // Block main goroutine forever.
    <-make(chan struct{})
}

func getFilePath(args []string) string {
    if (len(args) < 1) {
        log.Fatalln("You must specify a file path to watch!")
        os.Exit(1)
    }

    return args[0]
}

func getSyslog() *log.Logger {
    logger,err := syslog.NewLogger(syslog.LOG_INFO, 0)
    if err != nil {
        log.Fatal(err)
        os.Exit(2)
    }

    return logger
}

func start(watcher Watcher, filePath string) {
    watcher.start(filePath)
}

func main() {
    filePath := getFilePath(os.Args[1:])
    fsWatcher := FsnotifyWatcher {}
    start(fsWatcher, filePath)
}
